local group = vim.api.nvim_create_augroup("nvim12.core", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Dim listchars (space/tab/trail/eol/...) so they're visible but unobtrusive
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "#313244" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "#313244" })
  end,
})
vim.cmd("doautocmd ColorScheme")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  pattern = {
    "lua", "vim", "help",
    "python",
    "vue", "typescript", "typescriptreact", "javascript", "javascriptreact",
    "html", "css",
    "json", "yaml", "toml",
    "bash", "sh",
    "markdown",
    "gitcommit", "diff",
  },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
