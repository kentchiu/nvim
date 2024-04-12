return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require('rest-nvim').setup({})
      vim.keymap.set("n", "<leader>rrr", "<cmd>Rest run<cr>", { desc = "RestNvim Run" })
      vim.keymap.set("n", "<leader>rrl", "<cmd>Rest Last<cr>", { desc = "RestNvim Last" })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>r"] = { name = "run in" }
      opts.defaults["<leader>rr"] = { name = "restful" }
    end,
  },
}
