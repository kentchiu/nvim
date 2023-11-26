-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here


-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescript", "html" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Treesitter automatic Python format rtrings
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.py" },
  group = "py-fstring",
  --- @param opts AutoCmdCallbackOpts
  --- @return nil
  callback = function(opts)
    -- Only run if f-string escape character is typed
    if vim.v.char ~= "{" then
      return
    end

    -- Get node and return early if not in a string
    local node = vim.treesitter.get_node()

    if not node then
      return
    end
    if node:type() ~= "string" then
      node = node:parent()
    end
    if not node or node:type() ~= "string" then
      return
    end

    vim.print(node:type())
    local row, col, _, _ = vim.treesitter.get_node_range(node)

    -- Return early if string is already a format string
    local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
    vim.print("row " .. row .. " col " .. col)
    vim.print("char: '" .. first_char .. "'")
    if first_char == "f" then
      return
    end

    -- Otherwise, make the string a format string
    vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
  end,
})



-- wrap on markdown filetype
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = {'markdown'},
--   desc = 'Word wrap on Markdown',
--   callback = function()
--     vim.opt_local.wrap = true
--   end
-- })
--
