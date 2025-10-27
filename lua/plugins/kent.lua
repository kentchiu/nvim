return {
  {
    "kentchiu/aider.nvim",
    enabled = false,
    -- dir = "~/dev/kent/aider.nvim",
    dev = false,
    opts = {
      logger = {
        level = "OFF",
      },
    },
  },
  {
    "kentchiu/tmux-send.nvim",
    -- dir = "~/dev/kent/tmux-send.nvim",
    lazy = false,
    enabled = true,
    dev = false,
    opts = {
      logger = {
        level = "OFF",
      },
    },
  },
  {
    "kentchiu/d2.nvim",
    -- dir = "~/dev/kent/d2.nvim",
    lazy = false,
    dev = false,
    opts = {
      logger = {
        level = "OFF",
      },
    },
  },
  {
    "ravsii/tree-sitter-d2",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = "*", -- use the latest git tag instead of main
    build = "make nvim-install",
  },
  {
    "kentchiu/olink.nvim",
    enabled = false,
    -- dir = "~/dev/kent/olink.nvim",
    lazy = false,
    dev = false,
  },
}
