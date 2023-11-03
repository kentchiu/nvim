return {
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    opts = {

    },
    config = function(_, opts)
      -- Remaps for the refactoring operations currently offered by the plugin
      vim.api.nvim_set_keymap("v", "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Extract Function" })
      vim.api.nvim_set_keymap("v", "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Extract Function To File" })
      vim.api.nvim_set_keymap("v", "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Extract variable" })
      vim.api.nvim_set_keymap("v", "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Inline variable" })

      -- Extract block doesn't need visual mode
      vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Extract block" })
      vim.api.nvim_set_keymap("n", "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Extract Block To File" })

      -- Inline variable can also pick up the identifier currently under the cursor without visual mode
      vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false, desc = "Inline variable" })
      -- prompt for a refactor to apply when the remap is triggered
      vim.api.nvim_set_keymap("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>",
        { noremap = true, silent = true, expr = false, desc = "Refactor" })

      -- You can also use below = true here to to change the position of the printf
      -- statement (or set two remaps for either one). This remap must be made in normal mode.
      vim.keymap.set("n", "<leader>rp", function() require('refactoring').debug.printf({ below = false }) end,
        { noremap = true, desc = "Printf" })

      -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
      vim.api.nvim_set_keymap("n", "<leader>rv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
        { noremap = true, desc = "Print variable" })

      -- Remap in visual mode will print whatever is in the visual selection
      vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>",
        { noremap = true, desc = "Print variable" })

      -- Cleanup function: this remap should be made in normal mode
      vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>",
        { noremap = true, desc = "Cleanup" })



      require("refactoring").setup({
        -- overrides
        printf_statements = {
          typescript = {
            'console.log("🟥 %s");',
          },
          typescriptreact = {
            'console.log("🟥 %s");',
          },
          python = {
            'print(f"🟥 %s")'
          }
        },
        print_var_statements = {
          typescript = {
            'console.info("🟥 %s", %s);',
          },
          typescriptreact = {
            'console.info("🟥 %s", %s);',
          },
          python = {
            'print(f"🟥 %s {str(%s)}")'
          }
        },
      })
    end
  }
}
