return
{
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fF", "<cmd>cd %:p:h<cr><cmd>Telescope find_files<cr>", desc = "Find Files(cwd)" },
      { "<leader>sG", "<cmd>cd %:p:h<cr><cmd>Telescope live_grep<cr>",  desc = "Grep(cwd)" },
    },
    opts = {
      defaults = {
        -- layout_strategy = "vertical",
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        dynamic_preview_title = true,
        winblend = 70,
        multi_icon = '+',
        layout_config = {
          height = 0.95,
          width = 0.95,
          preview_width = 0.6,
          prompt_position = "top"
        },
        -- sorting_strategy = "ascending",
      },
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "undo history" }
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
          -- use_delta = true,
          -- use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          -- side_by_side = true,
          -- diff_context_lines = vim.o.scrolloff,
          -- entry_format = "state #$ID, $STAT, $TIME",
          -- time_format = "",
          saved_only = true,
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
}
