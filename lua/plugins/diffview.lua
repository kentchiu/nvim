return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>go", "<cmd>DiffviewOpen<cr>", { desc = "Open Changes" })
      vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch History" })
      vim.keymap.set("n", "<leader>gF", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "File History" })
    end,
  },
}
