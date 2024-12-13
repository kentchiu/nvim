return {
  {
    "kentchiu/nvim-aider",
    cmd = {
      "AiderTerminalToggle",
    },
    keys = {
      { "<leader>add", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
      { "<leader>ad/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
      { "<leader>ads", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>adc", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
      { "<leader>adb", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
      { "<leader>ad+", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
      { "<leader>ad-", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
    },
    dependencies = {
      "folke/snacks.nvim",
      "nvim-telescope/telescope.nvim",
      --- The below dependencies are optional
      "catppuccin/nvim",
    },
    opts = {
      -- Command line arguments passed to aider
      args = {
        "--no-auto-commits",
        "--pretty",
        "--stream",
        "--watch-file",
      },
    },
  },
}
