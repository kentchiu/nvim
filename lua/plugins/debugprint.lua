return {
  {
    'andrewferrier/debugprint.nvim',
    opts = {
      print_tag = "🟥",
      keymaps = {
        normal = {
          plain_below = "<leader>pp",
          plain_above = "<leader>pP",
          variable_below = "<leader>pv",
          variable_above = "<leader>pV",
          variable_below_alwaysprompt = nil,
          variable_above_alwaysprompt = nil,
          textobj_below = "<leader>po",
          textobj_above = "<leader>pO",
          toggle_comment_debug_prints = nil,
          delete_debug_prints = nil,
        },
        visual = {
          variable_below = "<leader>pv",
          variable_above = "<leader>pV",
        },
      },
      commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints",
        delete_debug_prints = "DeleteDebugPrints",
      },
    },
    config = function(_, opts, x)
      require("debugprint").setup(opts)

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
