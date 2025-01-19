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
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = true },
  -- { "nvimdev/dashboard-nvim", enabled = false },
  -- { "akinsho/bufferline.nvim", enabled = true },
  { "akinsho/bufferline.nvim", enabled = true },
}
--
--
local DISABLED_FOR_NON_DEV = {
  -- { "keaising/im-select.nvim", enabled = false },
  { "nvim-neotest/neotest", enabled = false },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "epwalsh/obsidian.nvim", enabled = false },
  { "yetone/avante.nvim", enabled = false },
}

local results = {}

-- concat others, disables, and kentOnly
results = vim.list_extend(results, others)
results = vim.list_extend(results, disables)

local user = os.getenv("USER")
if user ~= "kent" and user ~= "kentchiu" then
  results = vim.list_extend(results, DISABLED_FOR_NON_DEV)
end

return results
