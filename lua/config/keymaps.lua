-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

-- make page forward/backwoard firendly
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll window Downwards And Center It" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll window Upwards And Center It" })

-- remove ^M
vim.keymap.set("n", "<leader>bc", "<cmd>%s/\\r$//g<cr>", { desc = "remove ^M" })

--Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- HL as amplified versions of hjkl
vim.keymap.set({ "n", "v", "o", "x" }, "H", "0^") -- "beginning of line"
vim.keymap.set({ "n", "v", "o", "x" }, "L", "$") --"end of line"
vim.keymap.set({ "n", "v", "o", "x" }, "M", "gm") --"middle of line"

-- cd to current folder
-- vim.keymap.set("n", "<leader>bc", "<cmd>cd %:p:h<cr>", { desc = "Change to current folder" })
-- Copy file paths
vim.keymap.set("n", "<leader>fP", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>fp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })
vim.keymap.set("n", "<leader>fa", '<cmd>let @+ = expand("%:.")<CR>', { desc = "Copy Relative File Path" })
--

-- Obsidian
-- vim.keymap.set(
--   "n",
--   "<leader>oc",
--   "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
--   { desc = "Obsidian Check Checkbox" }
-- )
-- vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
-- vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
-- vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
-- vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
-- vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
-- vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
-- vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
-- misc

-- Inspect TreeSitter
-- vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

vim.keymap.del("n", "<leader>ft")
vim.keymap.set("n", "<leader>ft", "<cmd>vsplit<CR><cmd>terminal<CR>", { desc = "Termial" })

-- vim.keymap.del("n", "<leader>ft")
-- vim.keymap.del("n", "<leader>fT")
-- vim.keymap.del("n", "<c-/>")
-- vim.keymap.del("t", "<c-/>")
