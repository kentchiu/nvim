local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.updatetime = 250
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.pummaxwidth = 40
opt.pumborder = "rounded"
opt.winborder = "rounded"

vim.o.autocomplete = true
