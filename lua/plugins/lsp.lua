return {
  -- LSP keymaps
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   init = function()
  --     local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     -- change a keymap
  --     -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
  --     -- disable a keymap
  --     -- keys[#keys + 1] = { "K", false }
  --     -- add a keymap
  --     -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
  --     -- keys[#keys + 1] = {
  --     --   "gR",
  --     --   function()
  --     --     require("telescope.builtin").lsp_references({ jump_type = "vsplit" })
  --     --   end,
  --     --   "Go To References(vsplit)",
  --     -- }
  --     keys[#keys + 1] = { "gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition" }
  --   end,
  -- },
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
      local vue_typescript_plugin = require('mason-registry')
          .get_package('vue-language-server')
          :get_install_path()
          .. '/node_modules/@vue/language-server'
          .. '/node_modules/@vue/typescript-plugin'

      require 'lspconfig'.tsserver.setup {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_typescript_plugin,
              languages = { "vue" },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }

      require 'lspconfig'.volar.setup {};
    end,
  }
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --
  --     bind = true, -- This is mandatory, otherwise border config won't get registered.
  --     handler_opts = {
  --       border = "rounded"
  --     }
  --   },
  --   config = function(_, opts) require 'lsp_signature'.setup(opts) end
  -- }
}
