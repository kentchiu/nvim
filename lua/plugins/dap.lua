-- vim.keymap.set({ "n", "i" }, "<leader>dP", "import pdb;pdb.set_trace()")

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dL",
        function()
          require("dap.ext.vscode").load_launchjs()
        end,
        desc = "Load launchjs",
      },
    },
  },
}
