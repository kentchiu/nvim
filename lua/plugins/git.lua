return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewOpen<cr>", { desc = "DV - Open Changes" })
      vim.keymap.set("n", "<leader>g%", "<cmd>DiffviewFileHistory %<cr>", { desc = "DV - Current File History" })
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", { desc = "DV - Current File History" })
      vim.keymap.set("v", "<leader>gv", "<cmd>'<,'>DiffviewFileHistory<cr>", { desc = "DV - Current Selection" })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
  },
}
