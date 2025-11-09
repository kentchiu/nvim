return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "/home/kent/dev/kent/notes",
        },
      },
      disable_frontmatter = true,
      ui = {
        enable = false,
      },

      -- see below for full list of options 👇
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      local wk = require("which-key")

      wk.add({
        { "<leader>o", group = "obsidian" },
        {
          "<leader>oc",
          "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
          desc = "Obsidian Check Checkbox",
        },
        { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Obsidian Template" },
        { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian App" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show ObsidianBacklinks" },
        { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Show ObsidianLinks" },
        { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Create New Note" },
        { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian" },
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
      })
    end,
  },
}
