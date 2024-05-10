return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "angular-language-server")
      table.insert(opts.ensure_installed, "debugpy")
      table.insert(opts.ensure_installed, "html-lsp")
      table.insert(opts.ensure_installed, "js-debug-adapter")
      -- table.insert(opts.ensure_installed, "htmx-lsp")
      table.insert(opts.ensure_installed, "lua-language-server")
      table.insert(opts.ensure_installed, "vue-language-server")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      -- require('mason').setup({})
      local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"
        .. "/node_modules/@vue/typescript-plugin"

      -- require("lspconfig").tsserver.setup({
      --   init_options = {
      --     plugins = {
      --       {
      --         name = "@vue/typescript-plugin",
      --         location = vue_typescript_plugin,
      --         languages = { "typescript", "vue" },
      --       },
      --     },
      --   },
      --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      -- })
      --
      -- require("lspconfig").volar.setup({})
      --
      local lspconfig = require("lspconfig")

      -- lspconfig.tsserver.setup {}
      lspconfig.volar.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      })
    end,
  },
}
