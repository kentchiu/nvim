return {
  {
    'andrewferrier/debugprint.nvim',
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local opts = {
        print_tag = "🟥"
      }
    end,
  },
}
