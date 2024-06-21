-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

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

-- Inspect TreeSitter
-- vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

vim.keymap.del("n", "<leader>ft")
vim.keymap.set("n", "<leader>ft", "<cmd>vsplit<CR><cmd>terminal<CR>", { desc = "Termial" })

-- disable lazygit  keymap
vim.keymap.del("n", "<leader>gg") -- Lazygit (Root Dir)
vim.keymap.del("n", "<leader>gG") -- Lazygit (cwd)
vim.keymap.del("n", "<leader>gf") -- Laygit Current File History
vim.keymap.del("n", "<leader>gl") -- Lazygit Log
vim.keymap.del("n", "<leader>gL") -- Lazygit Log
vim.keymap.del("n", "<leader>gb") -- Laygit Blame line

-- keymap 的啟動會比所有的plugin 還晚, 無法在 plugin 裡面 overwrite lazymap default keymap
-- 所有目前只能寫在這裡, 才會 overwrite lazymap 的 keymap
-- vim.api.nvim_set_keymap("n", "<leader>gb", ":G blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
-- vim.keymap.set("n", "<leader>gl", ":Gclog<CR>", { desc = "Commit Log in Qfix" })
vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch History" })
