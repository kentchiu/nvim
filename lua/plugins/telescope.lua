return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fF", "<cmd>cd %:p:h<cr><cmd>Telescope find_files<cr>", desc = "Find Files(cwd)" },
    { "<leader>sG", "<cmd>cd %:p:h<cr><cmd>Telescope live_grep<cr>", desc = "Grep(cwd)" },
  },
}
