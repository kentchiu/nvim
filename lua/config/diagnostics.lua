vim.diagnostic.config({
  underline = true,         -- squiggly underline under diagnostic text
  update_in_insert = false, -- don't refresh while typing
  severity_sort = true,     -- show most severe first

  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },

  virtual_lines = { current_line = true }, -- full-width hint below cursor line only

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },

  float = {        -- popup window for open_float
    border = "rounded",
    source = true, -- always show source name
  },

  jump = {        -- behavior of [d / ]d
    float = true, -- auto-popup float after jump
  },
})
