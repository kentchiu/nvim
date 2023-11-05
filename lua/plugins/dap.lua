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
