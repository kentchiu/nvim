return {
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "LazyFile",
  --   opts = {
  --     signs = {
  --       add = { text = "+" },
  --       change = { text = "~" },
  --       delete = { text = "_" },
  --       topdelete = { text = "‾" },
  --       changedelete = { text = "~" },
  --     },
  --     on_attach = function(buffer)
  --       -- local gs = package.loaded.gitsigns
  --       --
  --       -- local function map(mode, l, r, desc)
  --       --   vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --       -- end
  --
  --       -- stylua: ignore start
  --       -- map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
  --       -- map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
  --       -- map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
  --       -- map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
  --       -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
  --       -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
  --       -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
  --       -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
  --       -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
  --       -- map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
  --       -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
  --       -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
  --       -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
  --       -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  --     end,
  --   },
  -- },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gfD", "<cmd>Gvdiffsplit<cr>", { desc = "Diff This(fix conflict)" })
      vim.keymap.set("n", "<leader>gfd", "<cmd>Git difftool<cr>", { desc = "Blame" })
      vim.keymap.set("n", "<leader>gfB", "<cmd>Git blame<cr>", { desc = "Blame" })
      vim.keymap.set("n", "<leader>gfm", "<cmd>Git mergetool<cr>", { desc = "mergetool" })
      vim.keymap.set("n", "<leader>gfl", "<cmd>Gclog<cr>", { desc = "Gclog" })
      -- vim.keymap.set("n", "<leader>gd", "<cmd>Gdiff<cr>", { desc = "Gdiff" })
      -- vim.keymap.set("n", "<leader>gD", "<cmd>Git log --stat -p<cr>", { desc = "Git log --stat -p" })
      -- vim.keymap.set("n", "<leader>ge", ":Gedit ", { desc = "Gedit" }) -- Gedit can take commit objects
      -- vim.keymap.set("n", "<leader>gl", [[<cmd>Git log --format="%h [%ad] [%an] %s"<cr>]], { desc = "Git log oneline" })
      -- vim.keymap.set("n", "<leader>gr", "<cmd>Gread<cr>", { desc = "Gread" })
      -- vim.keymap.set("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "Gwrite" })
      -- vim.keymap.set("n", "<leader>gu", "<cmd>diffupdate<cr>", { desc = "diffupdate" })
      -- vim.keymap.set("n", "<leader>g2", "<cmd>diffget //2<cr>", { desc = "diffget //2" })
      -- vim.keymap.set("n", "<leader>g3", "<cmd>diffget //3<cr>", { desc = "diffget //3" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gdd", "<cmd>DiffviewOpen<cr>", { desc = "Open Changes" })
      vim.keymap.set("n", "<leader>gdb", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch History" })
      vim.keymap.set("n", "<leader>gdf", "<cmd>DiffviewFileHistory --follow %<cr>", { desc = "File History" })
      vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "DiffviewClose" })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>gh"] = { name = "GitSigns" }
      opts.defaults["<leader>gd"] = { name = "DiffView" }
    end,
  },
}
