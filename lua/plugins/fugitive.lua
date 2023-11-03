return {
  {
    "tpope/vim-fugitive",
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch File History" })
      vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History" })
    end
  },
}
