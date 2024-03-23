return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      -- signs = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      --   untracked = { text = "▎" },
      -- },
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      -- on_attach = function(buffer)
      --   local gs = package.loaded.gitsigns
      --
      --   local function map(mode, l, r, desc)
      --     vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      --   end
      --
      --   -- stylua: ignore start
      --   map("n", "]h", gs.next_hunk, "Next Hunk")
      --   map("n", "[h", gs.prev_hunk, "Prev Hunk")
      --   map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      --   map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      --   map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      --   map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      --   map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      --   map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      --   map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      --   map("n", "<leader>ghd", gs.diffthis, "Diff This")
      --   map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      --   map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      --
      --
      --   -- No idea how to override keymap and key the config which setting by LazyVim
      --   -- The workaroud is copy whole config from LazyVim (https://www.lazyvim.org/plugins/editor#gitsignsnvim)
      --   -- and add extra config which we need
      --
      --   -- Highlight changed words.
      --   map("n", "<leader>ghw", gs.toggle_word_diff, "Toggle word diff")
      --   -- Highlight added lines.
      --   map("n", "<leader>gha", gs.toggle_linehl, "Toggle line highlight")
      --   -- Highlight removed lines.
      --   map("n", "<leader>ghr", gs.toggle_deleted, "Toggle deleted (all)")
      -- end,
    },
  }
}
