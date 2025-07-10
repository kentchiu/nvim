-- Disable autoformat for yaml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "http" },
  callback = function()
    vim.b.autoformat = false
  end,
})
