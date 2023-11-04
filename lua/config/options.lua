-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Relative line numbers
vim.opt.listchars = { space = "·", tab = "⇥ ", eol = "↵" }
vim.opt.swapfile = false -- disable swapfiles
-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { border = "rounded", })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, { border = "rounded" }
-- )

-- wrap on markdown filetype
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {'markdown'},
--   desc = 'Word wrap on Markdown',
--   callback = function()
--     vim.opt_local.wrap = true
--   end
-- })
--
