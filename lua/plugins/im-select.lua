return {
  {
    "keaising/im-select.nvim",
    enabled = false,
    config = function()
      -- windows
      -- 1033 is the IME ID for English US Keyboard
      -- 1028 is the IME ID for rime
      -- 2052 is the IME ID for sougo
      -- macos
      -- com.apple.keylayout.ABC is the IME ID for English US Keyboard
      local default_im_select = "1033"
      local default_command = "im-select.exe"

      if vim.fn.has('mac') == 1 then
        default_im_select = "com.apple.keylayout.ABC"
        default_command = "im-select"
      elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
        default_im_select = "1033"
        default_command = "im-select.exe"
      else
        default_im_select = "1033"
        default_command = "im-select.exe"
      end

      require("im_select").setup({
        -- IM will be set to `default_im_select` in `normal` mode
        -- For Windows/WSL, default: "1033", aka: English US Keyboard
        -- For macOS, default: "com.apple.keylayout.ABC", aka: US
        -- For Linux, default:
        --               "keyboard-us" for Fcitx5
        --               "1" for Fcitx
        --               "xkb:us::eng" for ibus
        -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
        default_im_select       = default_im_select,

        -- Can be binary's name or binary's full path,
        -- e.g. 'im-select' or '/usr/local/bin/im-select'
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "im-select"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        default_command         = default_command,

        -- Restore the default input method state when the following events are triggered
        set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

        -- Restore the previous used input method state when the following events
        -- are triggered, if you don't want to restore previous used im in Insert mode,
        -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
        -- as `set_previous_events = {}`
        set_previous_events     = { "InsertEnter" },

        -- Show notification about how to install executable binary when binary missed
        keep_quiet_on_no_binary = true,

        -- Async run `default_command` to switch IM or not
        async_switch_im         = true
      })
    end,
  }
}
