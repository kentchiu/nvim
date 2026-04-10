local map = vim.keymap.set

local function open_undotree()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end

local function open_difftool()
  vim.cmd.packadd("nvim.difftool")

  local left = vim.fn.input("Diff left: ", "", "file")
  if left == "" then
    return
  end

  local right = vim.fn.input("Diff right: ", "", "file")
  if right == "" then
    return
  end

  vim.cmd.DiffTool({ args = { left, right } })
end

map("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "Explorer" })
-- fzf
map("n", "<leader><space>", "<Cmd>FzfLua files<CR>", { desc = "Files" })
map("n", "<leader>:", "<Cmd>FzfLua command_history<CR>", { desc = "Command History" })
map("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fr", "<Cmd>FzfLua oldfiles<CR>", { desc = "Recent" })
map("n", "<leader>ff", "<Cmd>FzfLua<CR>", { desc = "FzfLua All" })
map("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Help" })


-- 
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gd", open_difftool, { desc = "Diff Tool" })
map("n", "<leader>su", open_undotree, { desc = "Undo Tree" })
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })


-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })


-- [[ Basic Keymaps ]]
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape" })

--Search word under cursor
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- HL as amplified versions of hjkl
vim.keymap.set({ "n", "x" }, "H", "0^") -- beginning of line
vim.keymap.set({ "n" }, "L", "$") --end of line
vim.keymap.set({ "x" }, "L", "g_") --end of line (without eol character)
vim.keymap.set({ "n", "x" }, "M", "%") --middle of line

vim.keymap.set("n", "g|", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vslipt" })

-- Open current markdown file with Typora
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>ct", function()
      local filepath = vim.fn.expand("%:p")
      vim.fn.jobstart({ "typora", filepath }, { detach = true })
    end, { buffer = true, desc = "Open in Typora" })
  end,
})


-- Better paste
-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
map("v", "p", '"_dP', { noremap = true, silent = true })


--
-- Taking from LazyVim
--
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")


-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })


-- Quickfix and location lists
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })
