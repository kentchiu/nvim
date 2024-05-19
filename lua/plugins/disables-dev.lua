local user = os.getenv("USER")

-- only enable these plugins for kent dev
if user == "kent" then
  return {}
end

return {
  { "robitx/gp.nvim", enabled = false },
  { "keaising/im-select.nvim", enabled = false },
  { "nvim-neotest/neotest", enabled = false },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap", enabled = false },
  { "mfussenegger/nvim-jdtls", enabled = false },
  { "mfussenegger/nvim-dap", enabled = false },
  { "rest-nvim/rest.nvim", enabled = false },
  { "epwalsh/obsidian.nvim", enabled = false },
  { "kristijanhusak/vim-dadbod-ui", enabled = true },
}
