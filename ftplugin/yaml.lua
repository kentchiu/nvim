-- Disable autoformat for yaml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
