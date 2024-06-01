-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for yaml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- wrap on markdown filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  desc = "No Word wrap on Markdown",
  callback = function()
    -- lazyvim will enable spell by default, but it will mass errors in Chinese content
    -- ref: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    vim.opt_local.spell = false
    vim.opt_local.wrap = false
  end,
})
