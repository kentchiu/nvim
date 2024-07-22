-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- Relative line numbers
vim.opt.listchars = { space = "·", tab = "⇥ ", eol = "↵" }
vim.opt.swapfile = false -- disable swapfiles
vim.opt.conceallevel = 0 -- disable conceal
vim.opt.inccommand = "split" -- Incremental live completion
