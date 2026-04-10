local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.setup({
  preset = "classic",
  delay = 200,
  icons = {
    mappings = false,
  },
  triggers = {
    { "<auto>", mode = "nxso" },
    { "<leader>", mode = { "n", "v" } },
  },
  win = {
    border = "rounded",
  },
})

wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>u", group = "Undo" },
})
