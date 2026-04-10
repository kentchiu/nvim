local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = "/usr/lib/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
}

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
  init_options = {
    plugins = { vue_plugin },
  },
}
