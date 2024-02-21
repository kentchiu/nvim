return {
  -- { "Mofiqul/dracula.nvim" },
  { "catppuccin/nvim",       name = "catppuccin", lazy = false },
  { "EdenEast/nightfox.nvim" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require("github-theme").setup({})
      -- random theme
      local items = {
        "onedark",
        -- "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        -- "onedark_vivid",
        -- "onedark_dark",
        "tokyonight-moon",
        "tokyonight-night",
        "tokyonight-storm",
        -- "dracula",
        -- "github_dark",
        -- "github_dark_tritanopia",
        -- "github_dark_high_contrast",
        -- "github_dark_dimmed",
        "nightfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox",
      }

      math.randomseed(os.time())
      local random_index = math.random(1, #items)
      local random_schema = "colorscheme" .. " " .. items[random_index]
      -- print("Theme: " .. random_schema)
      vim.cmd(random_schema)
    end,
  },
}
