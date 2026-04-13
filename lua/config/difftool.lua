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

-- close the ref-version scratch buffer (if any) and turn off diff
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

-- open a read-only split with the file content at the given ref
local function open_ref_split(ref)
  local filepath = vim.fn.expand("%:.")
  local content = vim.fn.systemlist("git show " .. ref .. ":" .. filepath)
  if vim.v.shell_error ~= 0 then
    return
  end

  local ft = vim.bo.filetype

  vim.cmd("leftabove vnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  vim.api.nvim_buf_set_name(buf, "diffref://" .. ref .. ":" .. filepath)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = ft
  vim.cmd("diffthis")

  -- move to the working tree window and enable diff
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

        local output = vim.fn.systemlist("git diff --name-only " .. ref)
        if vim.v.shell_error ~= 0 or #output == 0 then
          vim.notify("No differences found against " .. ref, vim.log.levels.INFO)
          return
        end

        local items = {}
        for _, file in ipairs(output) do
          table.insert(items, { filename = file, lnum = 1 })
        end
        vim.fn.setqflist(items, "r")
        vim.fn.setqflist({}, "a", { title = "Diff vs " .. ref })
        vim.cmd.copen()

        -- override Enter in quickfix to open file with diff
        vim.keymap.set("n", "<CR>", function()
          local idx = vim.fn.line(".")
          close_ref_split()
          vim.cmd("cc " .. idx)
          open_ref_split(ref)
        end, { buffer = true, nowait = true })
      end,
    },
  })
end

return M
