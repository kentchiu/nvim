return {
  {
    'andrewferrier/debugprint.nvim',
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local opts = {
        create_keymaps = false,
        print_tag = "🟥"
      }
      require("debugprint").setup(opts)

      vim.keymap.set("n", "<Leader>pp", function() return require('debugprint').debugprint() end,
        { expr = true, desc = "Print debug belowe", })
      vim.keymap.set("n", "<Leader>pP", function() return require('debugprint').debugprint({ above = true }) end,
        { expr = true, desc = "Plain debug above", })
      vim.keymap.set({ "n", "x" }, "<Leader>pv",
        function() return require('debugprint').debugprint({ variable = true }) end,
        { expr = true, desc = "Variable debug below", })
      vim.keymap.set({ "n", "x" }, "<Leader>pV",
        function() return require('debugprint').debugprint({ above = true, variable = true }) end,
        { expr = true, desc = "Variable debug above", })
      vim.keymap.set("n", "<Leader>po", function() return require('debugprint').debugprint({ motion = true }) end,
        { expr = true, desc = "Text-obj-selected below" })
      vim.keymap.set("n", "<Leader>pO",
        function() return require('debugprint').debugprint({ motion = true, above = true }) end,
        { expr = true, desc = "Text-obj-selected above" })
      vim.keymap.set("n", "<Leader>pd", "<CMD>DeleteDebugPrints<CR>", { desc = "Delete Prints." })
      vim.keymap.set("n", "<Leader>pl", function()
        vim.cmd("vimgrep " .. "/" .. opts.print_tag .. "/g `git ls-files`")
        vim.fn.execute('copen')
      end, { desc = "List All" })
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>p"] = { name = "print" }
    end,
  },
}
