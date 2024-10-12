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
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
      },
    },
    keys = {
      -- Run API request
      -- { "<leader>rR", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>rr", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      { "<leader>rRe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>rRm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      { "<leader>rRv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>rr", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.add({
        mode = { "n", "v" },
        { "<leader>r", group = "+run", icon = "" }, -- group
      })
    end,
  },
}
