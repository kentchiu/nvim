-- Disable unused remote plugin providers to suppress checkhealth warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

-- Line numbers: show absolute + relative for easy motion jumps
opt.number = true
opt.relativenumber = true

-- Search: case-insensitive unless query contains uppercase
opt.ignorecase = true
opt.smartcase = true

-- Enable 24-bit RGB color in the TUI
opt.termguicolors = true

-- Always show sign column to avoid text shifting when diagnostics appear
opt.signcolumn = "yes"

-- Indentation: use spaces, 2-space width
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Faster CursorHold trigger (default 4000ms), improves LSP hover/diagnostics responsiveness
opt.updatetime = 250

-- Use system clipboard for yank/paste
opt.clipboard = "unnamedplus"

-- Completion menu: show menu even for single match, don't auto-select, use popup window
opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Limit completion popup width
opt.pummaxwidth = 40

-- Rounded borders for completion popup and floating windows
opt.pumborder = "rounded"
opt.winborder = "rounded"

-- Enable built-in auto-completion
vim.o.autocomplete = true
