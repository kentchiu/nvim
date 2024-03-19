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
vim.keymap.set({ "n", "v", "o", "x" }, "L", "$")  --"end of line"
vim.keymap.set({ "n", "v", "o", "x" }, "M", "gm") --"middle of line"



-- cd to current folder
-- vim.keymap.set("n", "<leader>bc", "<cmd>cd %:p:h<cr>", { desc = "Change to current folder" })

--
-- misc

-- Inspect TreeSitter
vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })
