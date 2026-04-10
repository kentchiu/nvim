local ok, ui2 = pcall(require, "vim._core.ui2")
if ok then
  ui2.enable()
else
  vim.schedule(function()
    vim.notify("ui2 is unavailable in this Neovim build", vim.log.levels.WARN)
  end)
end

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded" },
})
