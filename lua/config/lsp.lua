vim.lsp.config("*", {})

local group = vim.api.nvim_create_augroup("nvim_lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    if client:supports_method("textDocument/foldingRange") then
      vim.api.nvim_set_option_value(
        "foldexpr",
        "v:lua.vim.lsp.foldexpr()",
        { win = 0, scope = "local" }
      )
    end

    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or "n", lhs, rhs, { buffer = args.buf, desc = desc })
    end

    -- builtin
    map("gra", vim.lsp.buf.code_action,     "Code action", { "n", "x" })
    map("grn", vim.lsp.buf.rename,          "Rename")
    map("grr", vim.lsp.buf.references,      "References")
    map("gri", vim.lsp.buf.implementation,  "Implementation")
    map("grt", vim.lsp.buf.type_definition, "Type definition")
    map("grx", vim.lsp.codelens.run,        "Code lens run")
    map("gO",  vim.lsp.buf.document_symbol, "Document symbol")
    -- convention
    map("gd", vim.lsp.buf.definition,      "Definition")
    map("gD", vim.lsp.buf.declaration,     "Declaration")
    map("gK", vim.lsp.buf.signature_help,  "Signature help")
    -- customize
    map("grf", vim.lsp.buf.format,         "Format", { "n", "x" })
    map("grc", vim.lsp.buf.incoming_calls, "Callers")
    map("grC", vim.lsp.buf.outgoing_calls, "Callees")
    map("grh", function() vim.lsp.buf.typehierarchy("subtypes") end,   "Subtypes")
    map("grH", function() vim.lsp.buf.typehierarchy("supertypes") end, "Supertypes")

  end,
})

vim.lsp.enable({ "lua_ls", "pylsp", "vtsls", "vue_ls", "tailwindcss" })
