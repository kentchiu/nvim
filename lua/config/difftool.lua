-- Directory / file diff workflow using native Neovim diff mode.
-- Every diff view puts the ref version (readonly scratch) on the LEFT
-- and the working tree (editable) on the RIGHT — matching `git diff`
-- and code review tools.

local M = {}

-- Prefix used when naming scratch buffers we create for the ref side.
-- close_diff_splits() uses this prefix to find and close old diff
-- windows before opening a new one.
local SCRATCH_PREFIX = "diffref://"

-- Display labels for the three git diff statuses we care about.
local STATUS_LABELS = { A = "[new]", D = "[del]", M = "[mod]" }


-- ============================================================================
-- Git helpers
-- ============================================================================

-- Build a fuzzy-searchable list of branches, tags, and recent commits.
-- Each entry is prefixed with [branch]/[tag]/[commit] so parse_ref() can
-- later strip the prefix. Commits are capped at 50 to keep fzf snappy.
local function git_ref_list()
  local lines = {}
  local function collect(args)
    local result = vim.system(args, { text = true }):wait()
    if result.code ~= 0 then return end
    for line in result.stdout:gmatch("[^\n]+") do
      -- Skip symbolic refs like "[branch] origin/HEAD -> origin/main"
      -- which are not valid ref names to diff against.
      if not line:find("->") then
        table.insert(lines, line)
      end
    end
  end
  collect({ "git", "branch", "-a", "--format=[branch] %(refname:short)" })
  collect({ "git", "tag", "--format=[tag] %(refname:short)" })
  collect({ "git", "log", "--oneline", "--max-count=50", "--format=[commit] %h %s" })
  return lines
end

-- Strip the [branch]/[tag]/[commit] prefix from an fzf selection.
local function parse_ref(selected)
  return selected:match("^%[%w+%]%s+(%S+)")
end

-- Fetch file content at `ref` as a list of lines, or nil if the file
-- doesn't exist at that ref (e.g. for newly added files).
-- An empty `ref` resolves to the index: `git show :path`.
local function git_show(ref, filepath)
  local result = vim.system({ "git", "show", ref .. ":" .. filepath }, { text = true }):wait()
  if result.code ~= 0 then
    return nil
  end
  return vim.split(result.stdout, "\n", { plain = true, trimempty = true })
end


-- ============================================================================
-- Buffer / window helpers
-- ============================================================================

-- Turn the current buffer into a named, readonly scratch buffer used
-- as the ref-version side of a diff view. `content` may be nil to
-- produce an empty buffer (for added/deleted files).
local function make_scratch(name, content, ft)
  local buf = vim.api.nvim_get_current_buf()
  if content then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  end
  vim.api.nvim_buf_set_name(buf, name)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = ft
end

-- Close leftover ref-side scratch splits and turn off diff mode in the
-- current window. Called before opening a new diff so windows don't
-- accumulate as the user navigates entries.
local function close_diff_splits()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    local is_scratch = name:match("^" .. SCRATCH_PREFIX)
    local is_diff = vim.wo[win].diff
    local is_qf = vim.bo[buf].buftype == "quickfix"
    if (is_scratch or is_diff) and not is_qf then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end
  pcall(vim.cmd, "diffoff")
end

-- Open a vertical split to the left with the ref version and enable
-- diff mode on both sides. Assumes the current window is already
-- positioned on the working-tree side (the right side).
local function open_ref_split(label, filepath, content)
  local ft = vim.filetype.match({ filename = filepath }) or ""
  vim.cmd("leftabove vnew")
  make_scratch(SCRATCH_PREFIX .. label .. ":" .. filepath, content, ft)
  vim.cmd("diffthis")
  vim.cmd.wincmd("l")
  vim.cmd("diffthis")
end


-- ============================================================================
-- Single-file diff
-- ============================================================================

-- Diff the current buffer against `ref`. `label` is what shows up in
-- the scratch buffer name (e.g. "index" reads nicer than an empty ref).
local function diff_current_against(ref, label)
  local filepath = vim.fn.expand("%:.")
  if filepath == "" then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  close_diff_splits()
  local content = git_show(ref, filepath)
  if not content then
    vim.notify(filepath .. " does not exist in " .. label, vim.log.levels.INFO)
    return
  end

  open_ref_split(label, filepath, content)
end


-- ============================================================================
-- Directory diff (quickfix-driven)
-- ============================================================================

-- Parse `git diff --name-status` output into quickfix items plus a
-- path→status lookup used when opening individual entries.
local function build_qf_items(output_lines)
  local items, statuses = {}, {}
  for _, line in ipairs(output_lines) do
    local status, file = line:match("^(%a)%s+(.+)$")
    if status and file then
      statuses[file] = status
      table.insert(items, {
        filename = file,
        lnum = 1,
        text = STATUS_LABELS[status] or ("[" .. status .. "]"),
      })
    end
  end
  return items, statuses
end

-- Open a diff view for one quickfix entry. Three shapes:
--   M (modified): ref version on left, working tree on right (editable)
--   A (added):    empty on left, working tree on right (all green)
--   D (deleted):  ref version on left, empty on right (all red)
--
-- For M/A the caller runs `:cc N` first, which moves to a non-qf
-- window and loads the file. For D the file doesn't exist, so we
-- jump to the previous window manually and create an empty buffer
-- there. Running `enew` in the quickfix window itself would replace
-- the quickfix list with a blank buffer.
local function open_qf_diff(ref, filepath, status)
  close_diff_splits()

  if status == "D" then
    local ft = vim.filetype.match({ filename = filepath }) or ""
    vim.cmd.wincmd("p")
    vim.cmd("enew")
    make_scratch(filepath, nil, ft)
  end

  -- For added files, the left side stays empty. For M/D we pull the
  -- file content from the ref.
  local content = status == "A" and nil or git_show(ref, filepath)
  if status ~= "A" and not content then return end

  open_ref_split(ref, filepath, content)
end


-- ============================================================================
-- Public API
-- ============================================================================

-- Diff the current file against the index (staged version).
function M.diff_file_vs_index()
  -- Empty ref makes `git show :path` resolve to the index.
  diff_current_against("", "index")
end

-- Diff the current file against HEAD.
function M.diff_file_vs_head()
  diff_current_against("HEAD", "HEAD")
end

-- Diff the current file against a ref picked via fzf.
function M.diff_file_against_ref()
  local fzf = require("fzf-lua")
  local refs = git_ref_list()
  if #refs == 0 then
    vim.notify("No git refs found", vim.log.levels.WARN)
    return
  end

  local filepath = vim.fn.expand("%:.")
  if filepath == "" then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  fzf.fzf_exec(refs, {
    prompt = "Diff " .. filepath .. " against> ",
    actions = {
      ["default"] = function(selected)
        local ref = parse_ref(selected[1])
        if not ref then
          vim.notify("Could not parse ref from selection", vim.log.levels.ERROR)
          return
        end
        diff_current_against(ref, ref)
      end,
    },
  })
end

-- Populate the quickfix with all changed files between working tree
-- and `ref`, then install a buffer-local <CR> mapping so each entry
-- opens in a diff split. `title` shows up in the quickfix title bar.
local function show_diff_quickfix(ref, title)
  local result = vim.system({ "git", "diff", "--name-status", ref }, { text = true }):wait()
  if result.code ~= 0 or result.stdout == "" then
    vim.notify("No differences found against " .. (title or ref), vim.log.levels.INFO)
    return
  end

  local lines = vim.split(vim.trim(result.stdout), "\n")
  local items, statuses = build_qf_items(lines)
  vim.fn.setqflist(items, "r")
  vim.fn.setqflist({}, "a", { title = "Diff vs " .. (title or ref) })
  vim.cmd.copen()

  -- Buffer-local override: <CR> opens a diff split instead of just
  -- jumping to the file. Scoped so it doesn't leak to other quickfix
  -- lists.
  vim.keymap.set("n", "<CR>", function()
    local idx = vim.fn.line(".")
    local entry = vim.fn.getqflist()[idx]
    if not entry then return end
    local filepath = vim.fn.bufname(entry.bufnr)
    local status = statuses[filepath] or "M"

    close_diff_splits()

    -- `:cc N` would warn for deleted files, so skip it there.
    if status ~= "D" then
      vim.cmd("cc " .. idx)
    end
    open_qf_diff(ref, filepath, status)
  end, { buffer = true, nowait = true })
end

-- Resolve the merge base of HEAD and `base_ref`. Returns nil (and
-- notifies) if the refs don't share history.
local function git_merge_base(base_ref)
  local result = vim.system({ "git", "merge-base", "HEAD", base_ref }, { text = true }):wait()
  if result.code ~= 0 then
    vim.notify("No merge base with " .. base_ref, vim.log.levels.WARN)
    return nil
  end
  return vim.trim(result.stdout)
end

-- Pick a ref via fzf, then list all changed files in the quickfix
-- window. Pressing <CR> on an entry opens that file in a diff split.
function M.diff_against_ref()
  local fzf = require("fzf-lua")
  local refs = git_ref_list()
  if #refs == 0 then
    vim.notify("No git refs found", vim.log.levels.WARN)
    return
  end

  fzf.fzf_exec(refs, {
    prompt = "Diff against> ",
    actions = {
      ["default"] = function(selected)
        local ref = parse_ref(selected[1])
        if not ref then
          vim.notify("Could not parse ref from selection", vim.log.levels.ERROR)
          return
        end
        show_diff_quickfix(ref, ref)
      end,
    },
  })
end

-- Pick a base ref via fzf and diff HEAD against the merge base of HEAD
-- and the chosen ref. Useful for reviewing a feature branch's own
-- changes when the base has advanced since the branch was cut.
function M.diff_against_merge_base()
  local fzf = require("fzf-lua")
  local refs = git_ref_list()
  if #refs == 0 then
    vim.notify("No git refs found", vim.log.levels.WARN)
    return
  end

  fzf.fzf_exec(refs, {
    prompt = "Merge base with> ",
    actions = {
      ["default"] = function(selected)
        local base = parse_ref(selected[1])
        if not base then
          vim.notify("Could not parse ref from selection", vim.log.levels.ERROR)
          return
        end
        local merge_base = git_merge_base(base)
        if not merge_base then return end
        show_diff_quickfix(merge_base, "merge-base(" .. base .. ")")
      end,
    },
  })
end

-- Pick a directory via fzf, then show its commit history in another
-- fzf window (with diff preview). fzf-lua's built-in git_commits
-- handles the second step; we just scope its `git log` to the path.
function M.path_history()
  local fzf = require("fzf-lua")
  fzf.fzf_exec("fd --type d --hidden --exclude .git", {
    prompt = "Directory> ",
    actions = {
      ["default"] = function(selected)
        local path = selected[1]
        if not path or path == "" then return end
        fzf.git_commits({
          cmd = string.format(
            "git log --color --pretty=format:'%%h %%ad %%s' --date=short -- %s",
            vim.fn.shellescape(path)
          ),
          prompt = "History " .. path .. "> ",
        })
      end,
    },
  })
end

return M
