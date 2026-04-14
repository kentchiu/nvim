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
    -- single-char prefixes blocked by auto-trigger safety filter
    { "m", mode = "n" },
  },
  win = {
    border = "rounded",
  },
})

wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>u", group = "Undo" },

  -- Built-in prefixes that which-key can't auto-detect
  { "Z", group = "Quit" },
  { "ZZ", desc = "Write & quit" },
  { "ZQ", desc = "Quit without save" },

  { "@", group = "Play macro" },
  { "@q", desc = "Play macro q" },
  { "@a", desc = "Play macro a" },
  { "@@", desc = "Repeat last macro" },

  { "m", group = "Set mark" },
  { "ma", desc = "Mark a (buffer-local)" },
  { "mA", desc = "Mark A (global)" },
})
