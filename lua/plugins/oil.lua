return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "File Exploror" },
      })
    end,
  }
}
