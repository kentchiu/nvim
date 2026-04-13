local map = vim.keymap.set

local function open_undotree()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end

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

local function create_ref_snapshot(ref, callback)
  local tmp_dir = "/tmp/nvim-difftool-" .. vim.fn.getpid()
  vim.fn.delete(tmp_dir, "rf")

  local diff_cmd = { "git", "diff", "--name-only", ref }
  vim.system(diff_cmd, { text = true }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify("git diff failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
      end)
      return
    end

    vim.schedule(function()
      local files = vim.split(vim.trim(result.stdout), "\n", { trimempty = true })
      if #files == 0 then
        vim.notify("No differences found against " .. ref, vim.log.levels.INFO)
        return
      end

      for _, file in ipairs(files) do
        local dest_dir = vim.fn.fnamemodify(tmp_dir .. "/" .. file, ":h")
        vim.fn.mkdir(dest_dir, "p")
      end

      local pending = #files
      for _, file in ipairs(files) do
        local dest = tmp_dir .. "/" .. file
        local show_cmd = { "git", "show", ref .. ":" .. file }
        vim.system(show_cmd, { text = true }, function(show_result)
          vim.schedule(function()
            if show_result.code == 0 then
              local f = io.open(dest, "w")
              if f then
                f:write(show_result.stdout)
                f:close()
              end
            end

            pending = pending - 1
            if pending == 0 then
              callback(tmp_dir)
            end
          end)
        end)
      end
    end)
  end)
end

local function open_directory_diff()
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

        create_ref_snapshot(ref, function(tmp_dir)
          vim.cmd.packadd("nvim.difftool")
          vim.cmd.DiffTool({ args = { tmp_dir, vim.fn.getcwd() } })

          vim.api.nvim_create_autocmd("BufWinLeave", {
            pattern = "*",
            callback = function(ev)
              if vim.fn.getbufvar(ev.buf, "&buftype") == "quickfix" then
                vim.fn.delete(tmp_dir, "rf")
                return true -- remove this autocmd
              end
            end,
          })
        end)
      end,
    },
  })
end


map("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "Explorer" })
-- fzf
map("n", "<leader><space>", "<Cmd>FzfLua<CR>", { desc = "FZF" })
map("n", "<leader>:", "<Cmd>FzfLua command_history<CR>", { desc = "Command History" })
map("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fr", "<Cmd>FzfLua oldfiles<CR>", { desc = "Recent" })
map("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Files" })
map("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Help" })

--
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>su", open_undotree, { desc = "Undo Tree" })

-- Diff: gitsigns-backed diff views (native nvim diff mode, respects `diffopt`)
map("n", "<leader>di", function() require("gitsigns").diffthis() end,     { desc = "Diff vs Index" })
map("n", "<leader>dh", function() require("gitsigns").diffthis("HEAD") end, { desc = "Diff vs HEAD" })
map("n", "<leader>dt", function() require("gitsigns").preview_hunk_inline() end, { desc = "Toggle Deleted (inline)" })
map("n", "<leader>dd", open_directory_diff, { desc = "Diff Directory vs Ref" })

-- Hunk navigation and inspection (non-destructive)
map("n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "Next Hunk" })
map("n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev Hunk" })
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end,           { desc = "Preview Hunk" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame Line" })

-- Hunk staging (visual mode stages only the selected lines within the hunk)
map({ "n", "v" }, "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map({ "n", "v" }, "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })


-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })


-- Disable accidental macro recording; use Q to record instead
map("n", "q", "<Nop>")
map("n", "Q", "q", { desc = "Record Macro" })

-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

--Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- HL as amplified versions of hjkl
vim.keymap.set({ "n", "x" }, "H", "0^") -- beginning of line
vim.keymap.set({ "n" }, "L", "$") --end of line
vim.keymap.set({ "x" }, "L", "g_") --end of line (without eol character)
vim.keymap.set({ "n", "x" }, "M", "%") --middle of line

vim.keymap.set("n", "g|", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vslipt" })

-- Open current markdown file with Typora
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>ct", function()
      local filepath = vim.fn.expand("%:p")
      vim.fn.jobstart({ "typora", filepath }, { detach = true })
    end, { buffer = true, desc = "Open in Typora" })
  end,
})


-- Better paste
-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
map("v", "p", '"_dP', { noremap = true, silent = true })


--
-- Taking from LazyVim
--
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")


-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- terminal
-- map("n", "<leader>t", "<cmd>below terminal<cr>", { desc = "Terminal" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })


-- Quickfix and location lists
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

