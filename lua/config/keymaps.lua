local map = vim.keymap.set

local function open_undotree()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end

map("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "Explorer" })

-- fzf
map("n", "<leader><space>", "<Cmd>FzfLua<CR>", { desc = "FZF" })
map("n", "<leader>:", "<Cmd>FzfLua command_history<CR>", { desc = "Command History" })
map("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fr", function() require("fzf-lua").oldfiles({ cwd_only = true }) end, { desc = "Recent" })
map("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Files" })
map("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Help" })

-- git
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gl", function()
  require("neogit").action("log", "log_current", { "--graph", "--decorate", "--color" })()
end, { desc = "Git Log Graph" })


-- Diff: native nvim diff mode, respects `diffopt`
map("n", "<leader>di", function() require("config.difftool").diff_file_vs_index() end, { desc = "Diff vs Index" })
map("n", "<leader>dh", function() require("config.difftool").diff_file_vs_head() end,  { desc = "Diff vs HEAD" })
map("n", "<leader>dt", function() require("gitsigns").preview_hunk_inline() end,       { desc = "Toggle Deleted (inline)" })
map("n", "<leader>db", "<Cmd>FzfLua git_bcommits<CR>",                                  { desc = "File Commits" })
map("n", "<leader>dc", function() require("config.difftool").diff_file_against_ref() end, { desc = "Diff File vs Ref" })
map("n", "<leader>dd", function() require("config.difftool").diff_against_ref() end,   { desc = "Diff Directory vs Ref" })
map("n", "<leader>dm", function() require("config.difftool").diff_against_merge_base() end, { desc = "Diff vs Merge Base" })
map("n", "<leader>dp", function() require("config.difftool").path_history() end,       { desc = "Path History" })

-- Hunk navigation and inspection (non-destructive)
map("n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "Next Hunk" })
map("n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev Hunk" })
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end,           { desc = "Preview Hunk" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame Line" })

-- Hunk staging (visual mode stages only the selected lines within the hunk)
map({ "n", "v" }, "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map({ "n", "v" }, "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })

-- which key
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
-- map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

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


-- quit
map("n", "<leader>qq", "<cmd>qa<cr>",  { desc = "Quit All" })
map("n", "<leader>qs", "<cmd>wqa<cr>", { desc = "Save & Quit All" })


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

map("n", "<leader>xu", open_undotree, { desc = "Undo Tree" })


-- Keep search matches centered
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Save with Ctrl-S in any mode
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==",       { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==",       { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi",{ desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi",{ desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv",       { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv",       { desc = "Move Selection Up" })

-- Buffer navigation
-- map("n", "<S-h>",       "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>",       "<cmd>bnext<cr>",     { desc = "Next Buffer" })
map("n", "[b",          "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b",          "<cmd>bnext<cr>",     { desc = "Next Buffer" })
-- map("n", "<leader>bb",  "<cmd>e #<cr>",       { desc = "Alternate Buffer" })
-- map("n", "<leader>`",   "<cmd>e #<cr>",       { desc = "Alternate Buffer" })
-- map("n", "<leader>bd",  "<cmd>bd<cr>",        { desc = "Delete Buffer" })

-- Window splits
-- map("n", "<leader>-",  "<C-W>s", { desc = "Split Below", remap = true })
-- map("n", "<leader>|",  "<C-W>v", { desc = "Split Right", remap = true })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Close Window", remap = true })

-- Quickfix navigation
map("n", "[q", vim.cmd.cprev, { desc = "Prev Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostic navigation (error-only variants)
map("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Error" })
map("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev Error" })
map("n", "]w", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Next Warning" })
map("n", "[w", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end, { desc = "Prev Warning" })

-- Toggle options
map("n", "<leader>ul", function() vim.wo.number = not vim.wo.number end,             { desc = "Toggle Line Numbers" })
map("n", "<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end,                 { desc = "Toggle Wrap" })
map("n", "<leader>us", function() vim.wo.spell = not vim.wo.spell end,               { desc = "Toggle Spell" })
map("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle Diagnostics" })

-- Terminal
map("n", "<leader>tb", "<cmd>below split | terminal<cr>i",     { desc = "Terminal Below" })
map("n", "<leader>tr", "<cmd>botright vsplit | terminal<cr>i", { desc = "Terminal Right" })

-- Terminal mode
map("t", "<esc><esc>", "<C-\\><C-n>",       { desc = "Enter Normal Mode" })
map("t", "<C-h>",      "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>",      "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>",      "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>",      "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })

-- lsp
map("n", "g|", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vslipt" })
