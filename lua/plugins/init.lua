local others = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Use traditional vim syntax for Vue instead of treesitter
      -- This fixes the issue where treesitter blocks vim syntax but doesn't provide highlighting
      highlight = {
        disable = { "vue" },
      },
    },
  },
}

local disables = {
  { "akinsho/bufferline.nvim", enabled = false },
}

local results = {}

-- concat others, disables, and kentOnly
results = vim.list_extend(results, others)
results = vim.list_extend(results, disables)

-- local user = os.getenv("USER")
-- if user ~= "kent" and user ~= "kentchiu" then
--   results = vim.list_extend(results, DISABLED_FOR_NON_DEV)
-- end

return results
