--
-- [[ Helpers ]]
--
local map = vim.keymap.set

local function open_undotree()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end


--
-- [[ Editing basics ]]
--
map("i", "jk", "<Esc>", { desc = "Escape" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Disable accidental macro recording; use Q to record instead
map("n", "q", "<Nop>")
map("n", "Q", "q", { desc = "Record Macro" })

-- Search word under cursor (no jump)
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- HLM as amplified versions of hjkl (override default screen top/mid/bottom)
map({ "n", "x" }, "H", "0^")  -- beginning of line
map({ "n" },      "L", "$")   -- end of line
map({ "x" },      "L", "g_")  -- end of line (without eol character)
map({ "n", "x" }, "M", "%")   -- match pair

-- Better paste: don't overwrite register in visual paste
map("v", "p", '"_dP', { noremap = true, silent = true })

-- Better indenting: keep selection after shift
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Keep search matches centered
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==",        { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==",        { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv",        { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv",        { desc = "Move Selection Up" })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")


--
-- [[ Windows ]]
--
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window",  remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase Window Height" })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease Window Height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })


--
-- [[ Buffers ]]
--
-- map("n", "<S-h>",      "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>",      "<cmd>bnext<cr>",     { desc = "Next Buffer" })
map("n", "[b",         "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b",         "<cmd>bnext<cr>",     { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>",       { desc = "Alternate Buffer" })
map("n", "<leader>`",  "<cmd>e #<cr>",       { desc = "Alternate Buffer" })
-- map("n", "<leader>bd", "<cmd>bd<cr>",        { desc = "Delete Buffer" })


--
-- [[ File / Explorer ]]
--
map("n", "<leader>e",       "<Cmd>Oil<CR>",                    { desc = "Explorer" })
map("n", "<leader><space>", "<Cmd>FzfLua<CR>",                 { desc = "FZF" })
map("n", "<leader>:",       "<Cmd>FzfLua command_history<CR>", { desc = "Command History" })
map("n", "<leader>/",       "<Cmd>FzfLua live_grep<CR>",       { desc = "Grep" })
map("n", "<leader>ff",      "<Cmd>FzfLua files<CR>",           { desc = "Files" })
map("n", "<leader>fg",      "<Cmd>FzfLua live_grep<CR>",       { desc = "Grep" })
map("n", "<leader>fb",      "<Cmd>FzfLua buffers<CR>",         { desc = "Buffers" })
map("n", "<leader>fh",      "<Cmd>FzfLua help_tags<CR>",       { desc = "Help" })
map("n", "<leader>fr",      function() require("fzf-lua").oldfiles({ cwd_only = true }) end, { desc = "Recent" })
map("n", "<leader>fn",      "<cmd>enew<cr>",                   { desc = "New File" })


--
-- [[ Git: status / log ]]
--
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gl", function()
  require("neogit").action("log", "log_current", { "--graph", "--decorate", "--color" })()
end, { desc = "Git Log Graph" })


--
-- [[ Git: diff ]]
-- Native nvim diff mode, respects `diffopt`
--
map("n", "<leader>di", function() require("config.difftool").diff_file_vs_index() end,       { desc = "Diff vs Index" })
map("n", "<leader>dh", function() require("config.difftool").diff_file_vs_head() end,        { desc = "Diff vs HEAD" })
map("n", "<leader>db", "<Cmd>FzfLua git_bcommits<CR>",                                       { desc = "File Commits" })
map("n", "<leader>dc", function() require("config.difftool").diff_file_against_ref() end,    { desc = "Diff File vs Ref" })
map("n", "<leader>dd", function() require("config.difftool").diff_against_ref() end,         { desc = "Diff Directory vs Ref" })
map("n", "<leader>dm", function() require("config.difftool").diff_against_merge_base() end,  { desc = "Diff vs Merge Base" })
map("n", "<leader>dp", function() require("config.difftool").path_history() end,             { desc = "Path History" })
map("n", "<leader>dq", function() require("config.difftool").close_diff() end,               { desc = "Close Diff" })


--
-- [[ Git: hunks ]]
-- Non-destructive nav/inspection, plus staging
--
map("n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "Next Hunk" })
map("n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev Hunk" })

map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end,              { desc = "Preview Hunk" })
map("n", "<leader>ht", function() require("gitsigns").preview_hunk_inline() end,       { desc = "Toggle Deleted (inline)" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame Line" })

-- Visual mode stages only the selected lines within the hunk
map({ "n", "v" }, "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map({ "n", "v" }, "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })


--
-- [[ LSP ]]
--
map("n", "g|", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vsplit" })


--
-- [[ Diagnostics ]]
-- Error-only and warning-only variants
--
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


--
-- [[ Lists: quickfix / loclist / undotree ]]
--
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

map("n", "[q", vim.cmd.cprev, { desc = "Prev Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })


--
-- [[ UI toggles ]]
--
map("n", "<leader>ul", function() vim.wo.number = not vim.wo.number end,                      { desc = "Toggle Line Numbers" })
map("n", "<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end,                          { desc = "Toggle Wrap" })
map("n", "<leader>us", function() vim.wo.spell = not vim.wo.spell end,                        { desc = "Toggle Spell" })
map("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle Diagnostics" })
map("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })
map("n", "grX", vim.diagnostic.open_float, { desc = "Diagnostic float" })


--
-- [[ Terminal ]]
--
map("n", "<leader>tb", "<cmd>below split | terminal<cr>i",     { desc = "Terminal Below" })
map("n", "<leader>tr", "<cmd>botright vsplit | terminal<cr>i", { desc = "Terminal Right" })

-- Terminal mode
map("t", "<esc><esc>", "<C-\\><C-n>",       { desc = "Enter Normal Mode" })
map("t", "<C-h>",      "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>",      "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>",      "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>",      "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })


--
-- [[ Save / Quit ]]
--
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>qq", "<cmd>qa!<cr>",  { desc = "Quit All" })
map("n", "<leader>qs", "<cmd>wqa<cr>", { desc = "Save & Quit All" })


--
-- [[ Which-key helpers ]]
--
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })


--
-- [[ Obsidian ]]
--
-- map("n", "<leader>oo", "<Cmd>Obsidian open<CR>",         { desc = "Open in Obsidian app" })
-- map("n", "<leader>on", "<Cmd>Obsidian new<CR>",          { desc = "New Note" })
map("n", "<leader>os", "<Cmd>Obsidian search<CR>",       { desc = "Search Notes" })
map("n", "<leader>oq", "<Cmd>Obsidian quick_switch<CR>", { desc = "Quick Switch" })
map("n", "<leader>ot", "<Cmd>Obsidian toc<CR>",          { desc = "TOC" })
map("n", "<leader>ob", "<Cmd>Obsidian backlinks<CR>",    { desc = "Backlinks" })
map("n", "<leader>og", "<Cmd>Obsidian tags<CR>",         { desc = "Tags" })
map("n", "<leader>or", "<Cmd>Obsidian rename<CR>",       { desc = "Rename Note" })
map("n", "<leader>op", "<Cmd>Obsidian paste_img<CR>",    { desc = "Paste Image" })
map("n", "<leader>ol", "<Cmd>Obsidian link<CR>",         { desc = "Link Selection" })
-- map("v", "<leader>oL", "<Cmd>Obsidian link_new<CR>",     { desc = "Link New Note" })
--

--
-- [[ Filetype-specific (buffer-local via autocmd) ]]
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("n", "<leader>ct", function()
      local filepath = vim.fn.expand("%:p")
      vim.fn.jobstart({ "typora", filepath }, { detach = true })
    end, { buffer = true, desc = "Open in Typora" })
  end,
})
