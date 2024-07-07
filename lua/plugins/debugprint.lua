return {
  {
    "andrewferrier/debugprint.nvim",
    lazy = false,
    dependencies = {
      "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
      "nvim-treesitter/nvim-treesitter", -- Needed to enable treesitter for NeoVim 0.8
    },
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
          toggle_comment_debug_prints = "<leader>pt",
          delete_debug_prints = "<leader>px",
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
    config = function(_, opts)
      local plugin = require("debugprint")

      local js = {
        left = 'console.warn("',
        right = '");',
        mid_var = '", ',
        right_var = ");",
        find_treesitter_variable = function(opts)
          if opts.node:type() == "property_identifier" then
            return opts.get_node_text(opts.node:parent())
          elseif opts.node:type() == "identifier" then
            return opts.get_node_text(opts.node)
          else
            return nil
          end
        end,
      }

      opts.filetypes = {
        ["vue"] = js,
      }
      plugin.setup(opts)

      vim.keymap.set("n", "<Leader>pl", function()
        vim.cmd("vimgrep " .. "/" .. opts.print_tag .. "/g `git ls-files`")
        vim.fn.execute("copen")
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
