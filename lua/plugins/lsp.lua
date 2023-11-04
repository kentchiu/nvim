return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
      table.insert(opts.ensure_installed, "angular-language-server")
      table.insert(opts.ensure_installed, "html-lsp")
      table.insert(opts.ensure_installed, "htmx-lsp")
      table.insert(opts.ensure_installed, "debugpy")
    end,
  },
}
