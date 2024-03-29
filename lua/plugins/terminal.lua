return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local opts = {
        open_mapping = [[<c-\>]],
        size = function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
          end
        end,
      };

      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal
      -- terminal
      --
      local float_zsh = Terminal:new {
        cmd = "zsh",
        direction = "float",
        float_opts = {
          --    border = "single" | "double" | "shadow" | "curved" | ... other options supported by win open
          border = "curved",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd "startinsert!"
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd "startinsert!"
        end,
        count = 103,
      }

      function terminal_toggle()
        float_zsh:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tr", "<cmd>ToggleTermSendCurrentLine<cr>",
        { noremap = true, silent = true, desc = "Run Current Line" })
      vim.api.nvim_set_keymap("v", "<leader>tr", "<cmd>ToggleTermSendCurrentLine<cr>",
        { noremap = true, silent = true, desc = "Run Current Line" })
      vim.api.nvim_set_keymap("v", "<leader>tv", "y<cmd>ToggleTermSendVisualSelection<cr>",
        { noremap = true, silent = true, desc = "Run Visual Selection" })


      vim.keymap.set({ "n", "i", "t" }, "<M-/>", "<cmd>101ToggleTerm direction=vertical<cr>",
        { desc = "Vertical Terminal" })
      vim.keymap.set({ "n", "i", "t" }, "<M-->", "<cmd>102ToggleTerm direction=horizontal<cr>",
        { desc = "horizontal Terminal" })
      vim.keymap.set({ "n", "i", "t" }, "<M-.>", "<cmd>lua terminal_toggle()<cr>", { desc = "Float Terminal" })
    end
  },
}
