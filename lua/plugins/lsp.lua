return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     table.insert(opts.ensure_installed, "angular-language-server")
  --     table.insert(opts.ensure_installed, "debugpy")
  --     table.insert(opts.ensure_installed, "html-lsp")
  --     table.insert(opts.ensure_installed, "js-debug-adapter")
  --     table.insert(opts.ensure_installed, "lua-language-server")
  --     table.insert(opts.ensure_installed, "vue-language-server")
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = {
  --       enabled = true,
  --       exclude = { "vue", "typescript" }, -- filetypes for which you don't want to enable inlay hints },
  --     },
  --   },
  -- },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
}
