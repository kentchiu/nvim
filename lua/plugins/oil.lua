return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>fe", "<cmd>Oil<cr>", desc = "Oil" },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
}
