local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("catppuccin/nvim") },

  { src = gh("stevearc/oil.nvim") },
  { src = gh("ibhagwan/fzf-lua") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("NeogitOrg/neogit") },
  { src = gh("echasnovski/mini.icons") },
}, {
  confirm = false,
})


local ok_mini_icons, mini_icons = pcall(require, "mini.icons")
if ok_mini_icons then
  mini_icons.setup()
  mini_icons.mock_nvim_web_devicons()
end

local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  -- Custom column: git_status
  -- Shows a 2-char porcelain code (e.g. " M", "??", "A ") next to each entry.
  local git_cache = {} -- { [dir] = { [name] = "XY" } }

  local function load_git(dir)
    -- Paths from `git status` are relative to the repo root, not `-C` dir.
    -- We need `--show-prefix` to strip the prefix and get paths relative to `dir`.
    local prefix = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-prefix" })[1]
    if vim.v.shell_error ~= 0 then
      git_cache[dir] = {}
      return
    end
    prefix = prefix or ""
    local out = vim.fn.systemlist({
      "git", "-C", dir, "status", "--porcelain=v1", "-uall",
    })
    if vim.v.shell_error ~= 0 then
      git_cache[dir] = {}
      return
    end
    local map = {}
    for _, line in ipairs(out) do
      if #line >= 4 then
        local code = line:sub(1, 2)
        local name = line:sub(4)
        name = name:match("^.* %-> (.*)$") or name
        -- Strip prefix so name is relative to current dir
        if prefix ~= "" and name:sub(1, #prefix) == prefix then
          name = name:sub(#prefix + 1)
        elseif prefix ~= "" then
          -- Entry is outside our dir, skip
          name = nil
        end
        if name then
          local top = name:match("^([^/]+)")
          if top and (not map[top] or top == name) then
            map[top] = code
          end
        end
      end
    end
    git_cache[dir] = map
  end

  vim.api.nvim_set_hl(0, "OilGitModified", { fg = "#e5c07b", bold = true })
  vim.api.nvim_set_hl(0, "OilGitUntracked", { fg = "#61afef", bold = true })
  vim.api.nvim_set_hl(0, "OilGitAdded", { fg = "#98c379", bold = true })
  vim.api.nvim_set_hl(0, "OilGitClean", { fg = "#5c6370" })

  require("oil.columns").register("git_status", {
    render = function(entry, _conf, bufnr)
      local dir = oil.get_current_dir(bufnr)
      if not dir then return nil end
      if not git_cache[dir] then load_git(dir) end
      local code = git_cache[dir][entry[2]] -- entry[2] is FIELD_NAME
      if not code then return nil end
      -- Collapse 2-char porcelain code into a single symbol
      local sym, hl
      if code:find("?", 1, true) then
        sym, hl = "?", "OilGitUntracked"
      elseif code:find("A", 1, true) then
        sym, hl = "A", "OilGitAdded"
      elseif code:find("D", 1, true) then
        sym, hl = "D", "OilGitModified"
      elseif code:find("[MRCU]") then
        sym, hl = "M", "OilGitModified"
      else
        return nil
      end
      return { sym, hl }
    end,
    parse = function(line, _conf)
      return line:match("^(%S+)%s+(.*)$")
    end,
  })

  oil.setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    columns = { "git_status", "icon" },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["gy"] = "actions.yank_entry",
      ["gY"] = { "actions.yank_entry", opts = { modify = ":." } },
    },
    view_options = {
      show_hidden = true,
    },
  })

  -- Invalidate cache when entering/refreshing an oil buffer so status stays fresh
  local group = vim.api.nvim_create_augroup("OilGitStatus", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "OilEnter",
    callback = function(args)
      local bufnr = args.data and args.data.buf
      if not bufnr then return end
      local dir = oil.get_current_dir(bufnr)
      if dir then
        git_cache[dir] = nil
      end
    end,
  })
end

local ok_fzf_lua, fzf_lua = pcall(require, "fzf-lua")
if ok_fzf_lua then
  fzf_lua.setup({
    "default",
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "vertical",
      },
    },
    files = {
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
    },
  })
end

local ok_neogit, neogit = pcall(require, "neogit")
if ok_neogit then
  neogit.setup({})
end
