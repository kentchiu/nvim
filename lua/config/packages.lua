local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("catppuccin/nvim") },
  { src = gh("nvim-treesitter/nvim-treesitter") },
  { src = gh("stevearc/oil.nvim") },
  { src = gh("ibhagwan/fzf-lua") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("NeogitOrg/neogit") },
}, {
  confirm = false,
})

local ok_treesitter, treesitter = pcall(require, "nvim-treesitter")
if ok_treesitter then
  treesitter.setup({})
end

local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  oil.setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["gy"] = "actions.yank_entry",
      ["gY"] = { "actions.yank_entry", opts = { modify = ":." } },
    },
    view_options = {
      show_hidden = true,
    },
  })
end

local ok_fzf_lua, fzf_lua = pcall(require, "fzf-lua")
if ok_fzf_lua then
  fzf_lua.setup({
    "default",
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "vertical",
      },
    },
    files = {
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
    },
  })
end

local ok_neogit, neogit = pcall(require, "neogit")
if ok_neogit then
  neogit.setup({})
end
