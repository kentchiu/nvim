return {
  "folke/snacks.nvim",
  -- priority = 1000,
  -- lazy = false,
  ---@type snacks.Config
  -- opts = {
  -- bigfile = { enabled = true },
  -- dashboard = { enabled = false },
  -- indent = { enabled = true },
  -- input = { enabled = true },
  -- notifier = {
  --   enabled = true,
  --   timeout = 3000,
  -- },
  -- quickfile = { enabled = true },
  -- scroll = { enabled = true },
  -- statuscolumn = { enabled = true },
  -- words = { enabled = true },
  -- styles = {
  --   notification = {
  --     -- wo = { wrap = true } -- Wrap notifications
  --   },
  -- },
  -- },
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,  -- 預設顯示 hidden files (以 . 開頭的檔案)
          -- ignored = true,  -- 若也想預設顯示 gitignore 的檔案，可取消註解
          auto_close = true,
          -- jump = { close = false },
          layout = {
            -- preset = "ivy",
            preview = true,
          },
          -- formatters = { file = { filename_only = true } },
          -- matcher = { sort_empty = true },
        },
      },
    },
  },
  -- stylua: ignore
  keys = {

    { "<leader>fa", function() Snacks.picker() end, desc = "All pickers" },
    { "<leader>su", function() Snacks.picker("undo") end, desc = "Undo" },
    --
    -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    -- { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    -- find
    -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    -- { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    -- { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    -- { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
    { "<leader>fR", LazyVim.pick("oldfiles"), desc = "Recent" },
    { "<leader>fr", LazyVim.pick("oldfiles", { filter = { cwd = true }}), desc = "Recent (cwd)" },
    -- git
    -- { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
    -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- Grep
    -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    -- { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    -- { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    -- { "<leader>sW", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
    -- { "<leader>sw", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
    -- search
    -- { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    -- { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    -- { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    -- { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    -- { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    -- { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    -- { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    -- { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    -- { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    -- { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    -- { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
  },
  -- init = function()
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "VeryLazy",
  --     callback = function()
  --       -- test snacks features
  --       --[[
  --       for i = 1, 10 do
  --         vim.defer_fn(function()
  --           vim.notify("Hello " .. i, "info", { id = "test" })
  --           Snacks.notify.info("Hello " .. i)
  --           dd(i)
  --         end, i * 500)
  --       end
  --       --]]
  --
  --       -- Setup some globals for debugging (lazy-loaded)
  --       _G.dd = function(...)
  --         Snacks.debug.inspect(...)
  --       end
  --       _G.bt = function()
  --         Snacks.debug.backtrace()
  --       end
  --       vim.print = _G.dd -- Override print to use snacks for `:=` command
  --
  --       -- Create some toggle mappings
  --       -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  --       -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  --       -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  --       -- Snacks.toggle.diagnostics():map("<leader>ud")
  --       -- Snacks.toggle.line_number():map("<leader>ul")
  --       -- Snacks.toggle
  --       --   .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  --       --   :map("<leader>uc")
  --       -- Snacks.toggle.treesitter():map("<leader>uT")
  --       -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  --       -- Snacks.toggle.inlay_hints():map("<leader>uh")
  --     end,
  --   })
  -- end,
}
