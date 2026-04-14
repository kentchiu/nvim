-- Disable unused remote plugin providers to suppress checkhealth warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

-- Line numbers: show absolute + relative for easy motion jumps
opt.number = true
opt.relativenumber = true

-- Don't wrap long lines by default; toggle with <leader>uw
opt.wrap = false

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
opt.autocomplete = true

-- Disable swap files
opt.swapfile = false

-- vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"
-- example here: https://vimways.org/2018/the-power-of-diff/
opt.diffopt = {
  "internal", -- use internal diffS
  "inline:char", -- Diff: enable word-level inline highlight (delta-like) and smarter line matching
  "filler", -- fill diff with empty row which make diff more Intuitive
  "closeoff", -- auto close diff when buffer close
  "context:12", -- diff conext line
  "algorithm:histogram", -- suit for small chunk
  "linematch:60",
  "indent-heuristic", -- smart indent
  -- "iwhite", -- this one, it doesn't fit all cases.
}
--
--

-- vim.opt.conceallevel = 0 -- disable conceal
opt.inccommand = "split" -- Incremental live completion
opt.spelllang = "en_us,cjk" -- cjk for Chinese, Japanese and korean

-- vim.opt.listchars = { space = "·", tab = "⇥ ", eol = "↵" }
opt.list = true
opt.listchars = {
  eol = "↲",
  tab = "⇥ ",
  nbsp = "␣",
  lead = "·",      -- 只點縮排 
  -- space = "·",
  -- trail = "·",     -- 標記行尾                                                    
  precedes = "<",
  extends = "›",
}


