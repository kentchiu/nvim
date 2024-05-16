return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(buffer)
        -- local gs = package.loaded.gitsigns
        --
        -- local function map(mode, l, r, desc)
        --   vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        -- end

        -- stylua: ignore start
        -- map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        -- map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        -- map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        -- map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        -- map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
        -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit<cr>", { desc = "Diff This(fix conflict)" })
      vim.keymap.set("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Blame" })
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
      opts.defaults["<leader>gd"] = { name = "DiffView" }
    end,
  },
}
