local env = vim.env
-- only kent's dev env has GOOGLE_API_KEY
if env.GOOGLE_API_KEY ~= nil then return {} end

return {
  { "kentchiu/gemini.nvim",    enabled = false },
  { "robitx/gp.nvim",          enabled = false },
  { "keaising/im-select.nvim", enabled = false },
  { "nvim.neotest/neotest",    enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  { "zbirenbaum/copilot.lua",  enabled = false },
}
