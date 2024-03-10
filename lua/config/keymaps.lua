-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

-- make page forward/backwoard firendly
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll window Downwards And Center It" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll window Upwards And Center It" })

-- remove ^M
vim.keymap.set("n", "<leader>bc", "<cmd>%s/\\r$//g<cr>", { desc = "remove ^M" })

--Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Paste without losing data in register
-- vim.keymap.set({ "n", "v" }, "gp", '"0p', { noremap = true, silent = true, desc = "Quick Paste" })

-- HL as amplified versions of hjkl
vim.keymap.set({ "n", "v", "o", "x" }, "H", "0^") -- "beginning of line"
vim.keymap.set({ "n", "v", "o", "x" }, "L", "$")  --"end of line"
vim.keymap.set({ "n", "v", "o", "x" }, "M", "gm") --"middle of line"



-- cd to current folder
-- vim.keymap.set("n", "<leader>bc", "<cmd>cd %:p:h<cr>", { desc = "Change to current folder" })

-- telescope
--    { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
-- vim.keymap.set("n", "<leaderFF>")
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- better up/down
-- Remap for dealing with word wrap
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- end
-- vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Add undo break-points
-- vim.keymap.set("i", ",", ",<c-g>u")
-- vim.keymap.set("i", ".", ".<c-g>u")
-- vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
-- vim.keymap.set("v", "<", "<gv")
-- vim.keymap.set("v", ">", ">gv")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- vim.keymap.set("n", "<leader>ur", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>",
--   { desc = "Redraw / clear hlsearch / diff update" })

-- highlights under cursor
-- vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

--
-- misc

-- Inspect TreeSitter
-- vim.keymap.set( "n" , "<leader>ci", "<cmd>Inspect<cr>", { desc = "Inspect TreeSitter Node" })

-- diagnostics
-- vim.keymap.set("n", "<leader>cx", function() vim.diagnostic.open_float({ border = "rounded" }) end, { desc = "View Diagnostics In Float Window" })

-- Clear search with <esc>
-- vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- create fold
-- vim.keymap.set("n", "<leader>z", "zf%", { desc = "Create Fold", remap = true })


-- unit tests
-- vim.keymap.set("n", "<leader>tt", "<cmd>!pytest<cr>", { desc = "Run Pytest Test" , silent = true })
