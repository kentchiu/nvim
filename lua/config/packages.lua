local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("catppuccin/nvim") },
  { src = gh("stevearc/oil.nvim") },
  { src = gh("ibhagwan/fzf-lua") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("NeogitOrg/neogit") },
  { src = gh("echasnovski/mini.icons") },
  { src = gh("lewis6991/gitsigns.nvim") },
  { src = gh("refractalize/oil-git-status.nvim") },
}, {
  confirm = false,
})


local ok_mini_icons, mini_icons = pcall(require, "mini.icons")
if ok_mini_icons then
  mini_icons.setup()
  mini_icons.mock_nvim_web_devicons()
end

local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  oil.setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    win_options = {
      signcolumn = "yes:2",
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["gy"] = "actions.yank_entry",
      ["gY"] = { "actions.yank_entry", opts = { modify = ":." } },
    },
    view_options = {
      show_hidden = true,
    },
  })
end

local ok_oil_git_status, oil_git_status = pcall(require, "oil-git-status")
if ok_oil_git_status then
  oil_git_status.setup({
    show_ignored = true,
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

local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if ok_gitsigns then
  gitsigns.setup()
end
