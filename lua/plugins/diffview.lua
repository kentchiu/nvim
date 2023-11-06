return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory<cr>", { desc = "Current Branch History" })
      vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current File History" })
    end,
  },
}
