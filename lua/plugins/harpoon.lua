return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Add File" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Toggle Quick Menu" })
      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Nav File 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Nav File 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Nav File 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Nav File 4" })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>h"] = { name = "harpoon" }
    end,
  },
}
