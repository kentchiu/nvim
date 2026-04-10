local map = vim.keymap.set

map("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "Explorer" })
map("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Files" })
map("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Help" })
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })
