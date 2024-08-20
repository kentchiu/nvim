local others = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "angular",
        "bash",
        "c",
        "c_sharp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "gitignore",
        "go",
        "html",
        "http",
        "hurl",
        "ini",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "properties",
        "proto",
        "python",
        "query",
        "regex",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
      },
    },
  },
}

local disables = {
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "linux-cultist/venv-selector.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },
}
--
local kentOnly = {
  { "keaising/im-select.nvim", enabled = false },
  { "nvim-neotest/neotest", enabled = false },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = false },
  { "epwalsh/obsidian.nvim", enabled = false },
}

local results = {}

-- concat others, disables, and kentOnly
results = vim.list_extend(results, others)
results = vim.list_extend(results, disables)

local user = os.getenv("USER")
if user ~= "kent" then
  results = vim.list_extend(results, kentOnly)
end

return results
