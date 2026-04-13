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
        vim.cmd.cfirst()
        require("gitsigns").diffthis(ref)
      end,
    },
  })
end

return M
