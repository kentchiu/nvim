return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "UtkarshKunwar/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_close = 0
    end,
  },
  -- {
  --   "brianhuster/live-preview.nvim",
  --
  --   dependencies = {
  --     "folke/snacks.nvim",
  --   },
  --   opts = {
  --     browser = "default",
  --     -- dynamic_root = true,
  --     -- picker = "snacks",
  --     port = 55500,
  --     sync_scroll = false,
  --   },
  -- },

  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   opts = {
  --     code = {
  --       sign = true,
  --       width = "block",
  --       right_pad = 1,
  --     },
  --     heading = {
  --       sign = true,
  --       signs = { "󰫎 " },
  --       icons = {},
  --       border = true,
  --       -- Always use virtual lines for heading borders instead of attempting to use empty lines.
  --       border_virtual = true,
  --     },
  --     checkbox = {
  --       enabled = false,
  --     },
  --     sign = {
  --       enabled = true,
  --     },
  --   },
  -- },
}
