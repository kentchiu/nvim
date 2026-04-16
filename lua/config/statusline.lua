local function setup_highlights()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then return end
  local p = palettes.get_palette()

  local sl_bg = p.mantle

  local groups = {
    StMode_N = { fg = p.base, bg = p.green, bold = true },
    StMode_I = { fg = p.base, bg = p.blue, bold = true },
    StMode_V = { fg = p.base, bg = p.mauve, bold = true },
    StMode_C = { fg = p.base, bg = p.peach, bold = true },
    StMode_R = { fg = p.base, bg = p.red, bold = true },
    StGit = { fg = p.blue, bg = sl_bg },
    StFile = { fg = p.text, bg = sl_bg },
    StDiagError = { fg = p.red, bg = sl_bg },
    StDiagWarn = { fg = p.yellow, bg = sl_bg },
    StMuted = { fg = p.overlay0, bg = sl_bg },
  }

  for name, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

setup_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("statusline_highlights", { clear = true }),
  callback = setup_highlights,
})

local mode_map = {
  ["n"]     = { text = " N ", hl = "StMode_N" },
  ["i"]     = { text = " I ", hl = "StMode_I" },
  ["v"]     = { text = " V ", hl = "StMode_V" },
  ["V"]     = { text = " V-L ", hl = "StMode_V" },
  ["\22"]   = { text = " V-B ", hl = "StMode_V" },  -- <C-V>
  ["c"]     = { text = " C ", hl = "StMode_C" },
  ["R"]     = { text = " R ", hl = "StMode_R" },
  ["t"]     = { text = " T ", hl = "StMode_N" },
}

local function mode_component()
  local raw = vim.api.nvim_get_mode().mode
  local m = mode_map[raw] or mode_map[raw:sub(1, 1)] or mode_map["n"]
  return "%#" .. m.hl .. "#" .. m.text .. "%*"
end

local function git_component()
  local head = vim.b.gitsigns_head
  if not head or head == "" then return "" end
  return "%#StGit#  " .. head .. "%*"
end

local function file_component()
  return "%#StFile#  %f%m%r%*"
end

local function diagnostics_component()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return "" end

  local counts = vim.diagnostic.count(0)
  local errors = counts[vim.diagnostic.severity.ERROR] or 0
  local warns = counts[vim.diagnostic.severity.WARN] or 0

  return table.concat({
    "%#StDiagError# " .. errors,
    "%#StDiagWarn#  " .. warns,
    "%*",
  })
end

local function filetype_component()
  local ft = vim.bo.filetype
  if ft == "" then return "" end
  return "%#StMuted#" .. ft .. "%*"
end

local function position_component()
  return "%#StMuted# %l:%c %p%%%*"
end

local SEP = "%#StMuted# | %*"

-- Global function required by %{%v:lua.Statusline()%}
function Statusline()
  local git = git_component()
  local diag = diagnostics_component()

  local left = { mode_component() }
  if git ~= "" then left[#left + 1] = git end
  left[#left + 1] = SEP
  left[#left + 1] = file_component()

  local right = {}
  if diag ~= "" then right[#right + 1] = diag end
  right[#right + 1] = SEP
  right[#right + 1] = filetype_component()
  right[#right + 1] = "  "
  right[#right + 1] = position_component()
  right[#right + 1] = " "

  return table.concat(left) .. "%=" .. table.concat(right)
end

vim.o.statusline = "%{%v:lua.Statusline()%}"
