-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true -- Relative line numbers
vim.opt.swapfile = false -- disable swapfiles
-- vim.opt.conceallevel = 0 -- disable conceal
vim.opt.inccommand = "split" -- Incremental live completion

-- vim.opt.listchars = { space = "·", tab = "⇥ ", eol = "↵" }
vim.opt.listchars = {
  eol = "↲",
  tab = "⇥ ",
  space = "·",
  trail = "·",
  extends = ">",
  precedes = "<",
  nbsp = "␣",
}
vim.g.lazyvim_picker = "snacks"
-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
-- vim.g.lazyvim_blink_main = false
