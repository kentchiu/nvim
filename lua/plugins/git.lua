return {
  { "lewis6991/gitsigns.nvim", enabled = false },
  {
    "tpope/vim-fugitive",
    config = function()
      -- stylua: ignore start
      -- vim.keymap.set("n", "<leader>ge", ":Gedit<CR>", { desc = "Gedit" }) -- Gedit can take commit objects
      -- vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { noremap = true, silent = false, desc = "Git vertical diff" })
      -- vim.keymap.set('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true, desc = "Git read" })
      -- vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { noremap = true, silent = true, desc = "Git write" })
      -- vim.keymap.set("n", "<leader>gl", ":Gclog<CR>", { desc = "Commit Log in Qfix" })
      -- vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch History" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewOpen<cr>", { desc = "Open Changes" })
      vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History" })
      vim.keymap.set("n", "<leader>gx", "<cmd>DiffviewClose<cr>", { desc = "DiffviewClose" })
    end,
  },
}
