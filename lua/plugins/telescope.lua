return {
  {
    "nvim-telescope/telescope.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    keys = {
      { "<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "Recent(cwd)" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>se", "<cmd>Telescope spell_suggest<cr>", desc = "Spell" },
      -- git
      { "<leader>gc", false },
      { "<leader>gs", false },
    },
    opts = {
      defaults = {
        -- bottom_paen, center, cursor, horizontal, vertical, flex
        layout_strategy = "horizontal",
        -- hidden, tail, absolute, smart, truncate, filename_first ,shorten
        path_display = { "filename_first" },
        dynamic_preview_title = true,
        -- layout_config = {
        --   width = 0.95,
        --   preview_width = 0.6,
        -- },
      },
      pickers = {
        grep_string = {
          layout_config = {
            width = 0.95,
            preview_width = 0.6,
          },
        },
        live_grep = {
          layout_config = {
            width = 0.95,
            preview_width = 0.6,
          },
        },
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).

      require("telescope").setup(opts)
      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sf", builtin.builtin, { desc = "Builtin" })
    end,
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
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "undo history" },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
          use_delta = true,
          -- use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          side_by_side = true,
          diff_context_lines = 6,
          -- diff_context_lines = vim.o.scrolloff,
          -- entry_format = "state #$ID, $STAT, $TIME",
          -- time_format = "",
          -- saved_only = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.7,
            preview_cutoff = 0.2,

            -- `prompt_position`: 提示符的位置，可以是 "bottom"、"top" 或 "hidden"。
            -- `preview_cutoff`: 預覽窗口的高度，當窗口高度超過此值時，將不會顯示預覽窗口。
            -- `width`: 定義 Telescope 窗口的寬度，可以是數字或百分比（例如，0.75）。
            -- `height`: 定義 Telescope 窗口的高度，可以是數字或百分比。
            -- `horizontal`: 定義水平布局的選項，例如 `preview_width`。
            -- `vertical`: 定義垂直布局的選項，例如 `preview_height`。
            -- `mirror`: 如果設置為 true，則會鏡像布局。
            -- `side_by_side`: 如果設置為 true，則結果和預覽窗口將並排顯示。
          },
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
