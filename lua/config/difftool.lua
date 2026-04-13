local M = {}

local function git_ref_list()
  local lines = {}
  local function collect(cmd)
    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error == 0 then
      vim.list_extend(lines, output)
    end
  end
  collect("git branch -a --format='[branch] %(refname:short)'")
  collect("git tag --format='[tag] %(refname:short)'")
  collect("git log --oneline --max-count=50 --format='[commit] %h %s'")
  return lines
end

local function parse_ref(selected)
  local ref = selected:match("^%[%w+%]%s+(%S+)")
  return ref
end

local function close_ref_split()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("^diffref://") then
      vim.api.nvim_win_close(win, true)
    end
  end
  pcall(vim.cmd, "diffoff")
end

local function create_scratch_buf(name, content, ft)
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

local function git_show(ref, filepath)
  local result = vim.system({ "git", "show", ref .. ":" .. filepath }, { text = true }):wait()
  if result.code ~= 0 then
    return nil
  end
  return vim.split(result.stdout, "\n", { plain = true })
end

local function open_diff_split(ref, filepath, status)
  local ft = vim.filetype.match({ filename = filepath }) or ""

  if status == "D" then
    -- deleted: right side is empty scratch, left side has ref content
    vim.cmd("enew")
    create_scratch_buf(filepath, nil, ft)
  end

  vim.cmd("leftabove vnew")

  if status == "A" then
    -- new file: left side is empty
    create_scratch_buf("diffref://" .. ref .. ":" .. filepath, nil, ft)
  else
    -- modified or deleted: left side has ref content
    local content = git_show(ref, filepath)
    if not content then return end
    create_scratch_buf("diffref://" .. ref .. ":" .. filepath, content, ft)
  end

  vim.cmd("diffthis")
  vim.cmd.wincmd("l")
  vim.cmd("diffthis")
end

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

        local result = vim.system({ "git", "diff", "--name-status", ref }, { text = true }):wait()
        if result.code ~= 0 or result.stdout == "" then
          vim.notify("No differences found against " .. ref, vim.log.levels.INFO)
          return
        end

        local file_statuses = {}
        local items = {}
        for _, line in ipairs(vim.split(vim.trim(result.stdout), "\n")) do
          local status, file = line:match("^(%a)%s+(.+)$")
          if status and file then
            file_statuses[file] = status
            local label = ({ A = "[new]", D = "[del]", M = "[mod]" })[status] or "[" .. status .. "]"
            table.insert(items, { filename = file, lnum = 1, text = label })
          end
        end

        vim.fn.setqflist(items, "r")
        vim.fn.setqflist({}, "a", { title = "Diff vs " .. ref })
        vim.cmd.copen()

        vim.keymap.set("n", "<CR>", function()
          local idx = vim.fn.line(".")
          local entry = vim.fn.getqflist()[idx]
          if not entry then return end
          local filepath = vim.fn.bufname(entry.bufnr)
          local status = file_statuses[filepath] or "M"

          close_ref_split()
          if status ~= "D" then
            vim.cmd("cc " .. idx)
          end
          open_diff_split(ref, filepath, status)
        end, { buffer = true, nowait = true })
      end,
    },
  })
end

local function diff_current_file_against(ref, label)
  local filepath = vim.fn.expand("%:.")
  if filepath == "" then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  close_ref_split()
  local content = git_show(ref, filepath)
  if not content then
    vim.notify(filepath .. " does not exist in " .. label, vim.log.levels.INFO)
    return
  end

  local ft = vim.bo.filetype
  vim.cmd("leftabove vnew")
  create_scratch_buf("diffref://" .. label .. ":" .. filepath, content, ft)
  vim.cmd("diffthis")
  vim.cmd.wincmd("l")
  vim.cmd("diffthis")
end

function M.diff_file_vs_index()
  -- empty ref means index: `git show :path` shows staged version
  diff_current_file_against("", "index")
end

function M.diff_file_vs_head()
  diff_current_file_against("HEAD", "HEAD")
end

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
        diff_current_file_against(ref, ref)
      end,
    },
  })
end

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
