local user = os.getenv('USER')

-- only enable these plugins for kent dev
if user == 'kent' then return {} end

return {
  { "robitx/gp.nvim",          enabled = false },
  { "keaising/im-select.nvim", enabled = false },
  { "nvim.neotest/neotest",    enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  { "zbirenbaum/copilot.lua",  enabled = false },
}
