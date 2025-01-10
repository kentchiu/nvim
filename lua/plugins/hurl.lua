return {
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = true,
      -- Show notification on run
      show_notification = true,
      -- Show response in popup or split
      mode = "popup",
      -- Default formatter
      formatters = {
        json = { "jq" },
        html = {
          "prettier",
          "--parser",
          "html",
        },
        xml = {
          "tidy",
          "-xml",
          "-i",
          "-q",
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.add({
        mode = { "n", "v" },
        { "<leader>r", group = "+run", icon = "" }, -- group
        { "<leader>rr", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request", icon = "", mode = { "n", "v" } },
        { "<leader>rv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode", icon = "", mode = { "n", "v" } },
        { "<leader>rRe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry", icon = "" },
        { "<leader>rRm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode", icon = "" },
      })
    end,
  },
}
