return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- random theme
      local items = {
        -- "onedark",
        -- "catppuccin-latte",
        -- "catppuccin",
        -- "catppuccin-frappe",
        -- "catppuccin-macchiato",
        -- "catppuccin-mocha",
        -- "tokyonight",
        "tokyonight-moon",
        -- "tokyonight-night",
        -- "tokyonight-storm",
        --
      }

      math.randomseed(os.time())
      local random_index = math.random(1, #items)
      local random_schema = "colorscheme" .. " " .. items[random_index]
      vim.cmd(random_schema)
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      -- Ensure termguicolors is enabled if not already
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup({
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = "background",
      })
    end,
  },
}
