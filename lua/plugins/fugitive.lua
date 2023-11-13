return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Diff This" })
      vim.keymap.set("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Blame" })
    end,
  },
}
