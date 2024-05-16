-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Relative line numbers
vim.opt.listchars = { space = "·", tab = "⇥ ", eol = "↵" }
vim.opt.swapfile = false -- disable swapfiles
vim.opt.conceallevel = 0 -- disable conceal
-- Enable LazyVim auto format
-- vim.g.autoformat = false
-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { border = "rounded", })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, { border = "rounded" }
-- )
--
vim.opt.inccommand = "split" -- Incremental live completion
vim.opt.scrolloff = 999 -- Keep cursor centered
