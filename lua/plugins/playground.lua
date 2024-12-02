return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  { "willothy/flatten.nvim", config = true }, -- required for /editor command functionality
  {
    "aweis89/aider.nvim",
    dependencies = {
      "ibhagwan/fzf-lua", -- or "nvim-telescope/telescope.nvim"
      "willothy/flatten.nvim", -- required for /editor command functionality
    },
    init = function()
      require("aider").setup()
    end,
    -- e.x. mappings
    keys = {
      {
        "<leader>ab<space>",
        "<cmd>AiderToggle<CR>",
        desc = "Toggle Aider",
      },
      {
        "<leader>al",
        "<cmd>AiderLoad<CR>",
        desc = "Add file to aider",
      },
      {
        "<leader>ad",
        "<cmd>AiderAsk<CR>",
        desc = "Ask with selection",
        mode = { "v", "n" },
      },
    },
  },
}
