return {
  "echasnovski/mini.files",
  keys = {
    {
      "-",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (root)",
    },
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (directory of current file)",
    },
    -- {
    --   "<leader>fm",
    --   function()
    --     require("mini.files").open(LazyVim.root(), true)
    --   end,
    --   desc = "Open mini.files (root)",
    -- },
  },
  opts = {
    windows = {
      -- -- Maximum number of windows to show side by side
      -- max_number = math.huge,
      -- -- Whether to show preview of file/directory under cursor
      -- preview = false,
      -- -- Width of focused window
      -- width_focus = 50,
      -- -- Width of non-focused window
      -- width_nofocus = 15,
      -- Width of preview window
      width_preview = 75,
    },
  },
}
