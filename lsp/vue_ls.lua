return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = {
    "package.json",
    "vue.config.js",
    "vite.config.ts",
    ".git",
  },
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local ts_client = vim.lsp.get_clients({ name = "vtsls", bufnr = context.bufnr })[1]
      if not ts_client then
        vim.notify("vue_ls: missing vtsls client for tsserver/request", vim.log.levels.ERROR)
        return
      end

      local param = unpack(result)
      local id, command, payload = unpack(param)

      ts_client:exec_cmd({
        title = "vue_request_forward",
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, response)
        local body = response and response.body
        client:notify("tsserver/response", { { id, body } })
      end)
    end
  end,
}
