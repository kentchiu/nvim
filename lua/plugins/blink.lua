return {
  {
    "saghen/blink.cmp",
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      -- keymap = { preset = "super-tab" },
      --   highlight = {
      --     -- sets the fallback highlight groups to nvim-cmp's highlight groups
      --     -- useful for when your theme doesn't support blink.cmp
      --     -- will be removed in a future release, assuming themes add support
      --     use_nvim_cmp_as_default = false,
      --   },
      --   -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      --   -- adjusts spacing to ensure icons are aligned
      --   nerd_font_variant = "mono",
      --   windows = {
      --     autocomplete = {
      --       -- draw = "reversed",
      --       winblend = vim.o.pumblend,
      --     },
      --     documentation = {
      --       auto_show = true,
      --     },
      --     ghost_text = {
      --       enabled = vim.g.ai_cmp,
      --     },
      --   },
      --
      --   -- experimental auto-brackets support
      --   accept = { auto_brackets = { enabled = true } },
      --
      --   -- experimental signature help support
      --   -- trigger = { signature_help = { enabled = true } }
      --   sources = {
      --     -- adding any nvim-cmp sources here will enable them
      --     -- with blink.compat
      --     compat = {},
      --     completion = {
      --       -- remember to enable your providers here
      --       enabled_providers = { "lsp", "path", "snippets", "buffer" },
      --     },
      --   },
      --
      --   keymap = {
      --     preset = "enter",
      --     ["<Tab>"] = {
      --       LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
      --       "fallback",
      --     },
      --   },
    },
  },
}
