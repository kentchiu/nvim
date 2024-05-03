return {
  -- { "Mofiqul/dracula.nvim" },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
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
        "tokyonight-moon",
        "tokyonight-night",
        "tokyonight-storm",
        "nightfox",
        "duskfox",
        "nordfox",
        "terafox",
        -- "carbonfox",
      }

      math.randomseed(os.time())
      local random_index = math.random(1, #items)
      local random_schema = "colorscheme" .. " " .. items[random_index]
      -- print("Theme: " .. random_schema)
      vim.cmd(random_schema)
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    -- lazy = false,
    -- priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme cyberdream") -- set the colorscheme
    end,
  },
}
