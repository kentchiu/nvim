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
  { "<leader>f", group = "FZF" },
  { "<leader>g", group = "Git" },
  { "<leader>u", group = "UI" },
  { "<leader>d", group = "Diff" },
  { "<leader>h", group = "Hunk" },
  { "<leader>t", group = "Terminal" },
  { "<leader>x", group = "List" },
  { "<leader>q", group = "Quit" },

  -- Built-in prefixes that which-key can't auto-detect
  { "@", group = "Play macro" },
  { "@q", desc = "Play macro q" },
  { "@a", desc = "Play macro a" },
  { "@@", desc = "Repeat last macro" },

  { "m", group = "Set mark" },
  { "ma", desc = "Mark a (buffer-local)" },
  { "mA", desc = "Mark A (global)" },
})
