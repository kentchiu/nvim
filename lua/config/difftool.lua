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

        local changed = {}
        local items = {}
        for _, file in ipairs(output) do
          table.insert(items, { filename = file, lnum = 1 })
          changed[vim.fn.fnamemodify(file, ":p")] = true
        end
        vim.fn.setqflist(items, "r")
        vim.fn.setqflist({}, "a", { title = "Diff vs " .. ref })

        local group = vim.api.nvim_create_augroup("DiffAgainstRef", { clear = true })

        -- auto-trigger gitsigns diff when entering a changed file
        vim.api.nvim_create_autocmd("BufEnter", {
          group = group,
          callback = function()
            local bufpath = vim.api.nvim_buf_get_name(0)
            if changed[bufpath] and not vim.wo.diff then
              vim.defer_fn(function()
                pcall(require("gitsigns").diffthis, ref)
              end, 50)
            end
          end,
        })

        -- cleanup when quickfix window is closed
        vim.api.nvim_create_autocmd("BufWinLeave", {
          group = group,
          callback = function(ev)
            if vim.fn.getbufvar(ev.buf, "&buftype") == "quickfix" then
              pcall(vim.api.nvim_del_augroup_by_name, "DiffAgainstRef")
              return true
            end
          end,
        })

        vim.cmd.copen()
        vim.cmd.cfirst()
      end,
    },
  })
end

return M
