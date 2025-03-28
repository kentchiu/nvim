-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })
vim.keymap.set("i", "jjj", "<Esc>", { desc = "Escape" })

-- remove ^M
-- vim.keymap.set("n", "<leader>bc", "<cmd>%s/\\r$//g<cr>", { desc = "remove ^M" })

--Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- HL as amplified versions of hjkl
vim.keymap.set({ "n", "x" }, "H", "0^") -- beginning of line
vim.keymap.set({ "n" }, "L", "$") --end of line
vim.keymap.set({ "x" }, "L", "g_") --end of line (without eol character)
vim.keymap.set({ "n", "x" }, "M", "%") --middle of line

-- cd to current folder
-- vim.keymap.set("n", "<leader>bc", "<cmd>cd %:p:h<cr>", { desc = "Change to current folder" })
-- Copy file paths
-- vim.keymap.set("n", "<leader>fP", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
-- vim.keymap.set("n", "<leader>fp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })
-- vim.keymap.set("n", "<leader>fa", '<cmd>let @+ = expand("%:.")<CR>', { desc = "Copy Relative File Path" })
--
-- vim.keymap.set("n", "<leader>ft", function()
--   Snacks.terminal.open(nil, { win = { position = "right" } })
-- end, { desc = "Open Terminal in right" })
--
-- tab keymap
-- vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnext<cr>")
-- vim.keymap.set("n", "<leader><tab>h", "<cmd>tabfirst<cr><cmd>tabonly<cr>", { desc = "Keep First Tab Only" })
vim.keymap.set("n", "g|", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vslipt" })

-- map q: to nop in command mode
vim.keymap.set("c", "q:", "<nop>", { silent = true })

-- convinent keymap for code companion
-- vim.cmd([[cab cc CodeCompanion]])

-- Disable C-A which mis triigers which tmux leader key
vim.keymap.set("n", "<C-a>", "<nop>")

vim.keymap.set("n", "<leader>ps", "<cmd>source % <CR>", { desc = "Source Current File" })
vim.keymap.set("n", "<leader>pr", "<cmd>Lazy reload aider.nvim<CR>", { desc = "Reload plugin" })
vim.keymap.set("n", "<leader>pe", ":.lua<CR>", { desc = "Evaluate current line" })
vim.keymap.set("v", "<leader>pe", ":lua<CR>", { desc = "Evaluate current selection" })

-- Remap macro recording from q to ctrl+q
-- vim.keymap.set("n", "q", "<nop>", { desc = "Disable macro recording with q" })
-- vim.keymap.set("n", "<C-q>", "q", { desc = "Start/stop macro recording" })

-- playggroud
-- When lines are on, text is off. Text on, lines off. Minimize clutter.
-- vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
-- vim.keymap.set("", "<leader>uv", function()
--   vim.diagnostic.config({
--     virtual_lines = not vim.diagnostic.config().virtual_lines,
--     virtual_text = not vim.diagnostic.config().virtual_text,
--   })
-- end, { desc = "Toggle diagnostic lines" })
