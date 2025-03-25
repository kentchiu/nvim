return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      completions = {
        -- Settings for blink.cmp completions source
        blink = { enabled = false },
        -- Settings for coq_nvim completions source
        coq = { enabled = false },
        -- Settings for in-process language server completions
        lsp = { enabled = false },
      },
      -- Useful context to have when evaluating values.
      -- | level    | the number of '#' in the heading marker         |
      -- | sections | for each level how deeply nested the heading is |
      heading = {
        -- Turn on / off heading icon & background rendering.
        enabled = true,
        -- Additional modes to render headings.
        render_modes = false,
        -- Turn on / off any sign column related rendering.
        sign = true,
        -- Replaces '#+' of 'atx_h._marker'.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)`              |
        -- | string[] | `cycle(value, context.level)` |
        -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Determines how icons fill the available space.
        -- | right   | '#'s are concealed and icon is appended to right side                          |
        -- | inline  | '#'s are concealed and icon is inlined on left side                            |
        -- | overlay | icon is left padded with spaces and inserted on left hiding any additional '#' |
        position = "overlay",
        -- Added to the sign column if enabled.
        -- Output is evaluated by `cycle(value, context.level)`.
        signs = { "󰫎 " },
        -- Width of the heading background.
        -- | block | width of the heading text |
        -- | full  | full width of the window  |
        -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
        width = "full",
        -- Amount of margin to add to the left of headings.
        -- Margin available space is computed after accounting for padding.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
        left_margin = 0,
        -- Amount of padding to add to the left of headings.
        -- Output is evaluated using the same logic as 'left_margin'.
        left_pad = 0,
        -- Amount of padding to add to the right of headings when width is 'block'.
        -- Output is evaluated using the same logic as 'left_margin'.
        right_pad = 0,
        -- Minimum width to use for headings when width is 'block'.
        -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
        min_width = 0,
        -- Determines if a border is added above and below headings.
        -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
        border = true,
        -- Always use virtual lines for heading borders instead of attempting to use empty lines.
        border_virtual = true,
        -- Highlight the start of the border using the foreground highlight.
        border_prefix = false,
        -- Used above heading for border.
        above = "▄",
        -- Used below heading for border.
        below = "▀",
        -- Highlight for the heading icon and extends through the entire line.
        -- Output is evaluated by `clamp(value, context.level)`.
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- Highlight for the heading and sign icons.
        -- Output is evaluated using the same logic as 'backgrounds'.
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        -- Define custom heading patterns which allow you to override various properties based on
        -- the contents of a heading.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern    | matched against the heading text @see :h lua-pattern |
        -- | icon       | optional override for the icon                       |
        -- | background | optional override for the background                 |
        -- | foreground | optional override for the foreground                 |
        custom = {},
      },
      code = {
        -- Turn on / off code block & inline code rendering.
        enabled = true,
        -- Additional modes to render code blocks.
        render_modes = false,
        -- Turn on / off any sign column related rendering.
        sign = true,
        -- Determines how code blocks & inline code are rendered.
        -- | none     | disables all rendering                                                    |
        -- | normal   | highlight group to code blocks & inline code, adds padding to code blocks |
        -- | language | language icon to sign column if enabled and icon + name above code blocks |
        -- | full     | normal + language                                                         |
        style = "full",
        -- Determines where language icon is rendered.
        -- | right | right side of code block |
        -- | left  | left side of code block  |
        position = "left",
        -- Amount of padding to add around the language.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        language_pad = 0,
        -- Whether to include the language icon above code blocks.
        -- language_icon = true,
        -- Whether to include the language name above code blocks.
        language_name = true,
        -- A list of language names for which background highlighting will be disabled.
        -- Likely because that language has background highlights itself.
        -- Use a boolean to make behavior apply to all languages.
        -- Borders above & below blocks will continue to be rendered.
        disable_background = { "diff" },
        -- Width of the code block background.
        -- | block | width of the code block  |
        -- | full  | full width of the window |
        width = "full",
        -- Amount of margin to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Margin available space is computed after accounting for padding.
        left_margin = 0,
        -- Amount of padding to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks when width is 'block'.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        right_pad = 0,
        -- Minimum width to use for code blocks when width is 'block'.
        min_width = 0,
        -- Determines how the top / bottom of code block are rendered.
        -- | none  | do not render a border                               |
        -- | thick | use the same highlight as the code body              |
        -- | thin  | when lines are empty overlay the above & below icons |
        border = "thick",
        -- Used above code blocks for thin border.
        above = "▄",
        -- Used below code blocks for thin border.
        below = "▀",
        -- Highlight for code blocks.
        highlight = "RenderMarkdownCode",
        -- Highlight for language, overrides icon provider value.
        highlight_language = nil,
        -- Highlight for language, used if icon provider does not have a value.
        -- highlight_fallback = "RenderMarkdownCodeFallback",
        -- Padding to add to the left & right of inline code.
        inline_pad = 0,
        -- Highlight for inline code.
        highlight_inline = "RenderMarkdownCodeInline",
      },
      -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
      -- There are two special states for unchecked & checked defined in the markdown grammar.
      pipe_table = {
        -- Turn on / off pipe table rendering.
        enabled = true,
        -- Additional modes to render pipe tables.
        render_modes = false,
        -- Pre configured settings largely for setting table border easier.
        -- | heavy  | use thicker border characters     |
        -- | double | use double line border characters |
        -- | round  | use round border corners          |
        -- | none   | does nothing                      |
        preset = "none",
        -- Determines how the table as a whole is rendered.
        -- | none   | disables all rendering                                                  |
        -- | normal | applies the 'cell' style rendering to each row of the table             |
        -- | full   | normal + a top & bottom line that fill out the table when lengths match |
        style = "full",
        -- Determines how individual cells of a table are rendered.
        -- | overlay | writes completely over the table, removing conceal behavior and highlights |
        -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
        -- | padded  | raw + cells are padded to maximum visual width for each column             |
        -- | trimmed | padded except empty space is subtracted from visual width calculation      |
        cell = "padded",
        -- Amount of space to put between cell contents and border.
        padding = 1,
        -- Minimum column width to use for padded or trimmed cell.
        min_width = 0,
        -- Characters used to replace table border.
        -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
        -- stylua: ignore
        border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
        },
        -- Gets placed in delimiter row for each column, position is based on alignment.
        alignment_indicator = "━",
        -- Highlight for table heading, delimiter, and the line above.
        head = "RenderMarkdownTableHead",
        -- Highlight for everything else, main table rows and the line below.
        row = "RenderMarkdownTableRow",
        -- Highlight for inline padding used to add back concealed space.
        filler = "RenderMarkdownTableFill",
      },
      sign = {
        -- Turn on / off sign rendering.
        enabled = true,
        -- Applies to background of sign text.
        highlight = "RenderMarkdownSign",
      },
      -- Mimics Obsidian inline highlights when content is surrounded by double equals.
      -- The equals on both ends are concealed and the inner content is highlighted.
      inline_highlight = {
        -- Turn on / off inline highlight rendering.
        enabled = true,
        -- Additional modes to render inline highlights.
        render_modes = false,
        -- Applies to background of surrounded text.
        highlight = "RenderMarkdownInlineHighlight",
      },
      -- Mimic org-indent-mode behavior by indenting everything under a heading based on the level of
      -- the heading. Indenting starts from level 2 headings onward by default.
      indent = {
        -- Turn on / off org-indent-mode.
        enabled = false,
        -- Additional modes to render indents.
        render_modes = false,
        -- Amount of additional padding added for each heading level.
        per_level = 2,
        -- Heading levels <= this value will not be indented.
        -- Use 0 to begin indenting from the very first level.
        skip_level = 1,
        -- Do not indent heading titles, only the body.
        skip_heading = false,
        -- Prefix added when indenting, one per level.
        icon = "▎",
        -- Applied to icon.
        highlight = "RenderMarkdownIndent",
      },
      -- Window options to use that change between rendered and raw view.
      win_options = {
        -- @see :h 'conceallevel'
        conceallevel = {
          -- Used when not being rendered, get user setting.
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          -- Used when being rendered, concealed text is completely hidden.
          rendered = 0,
        },
        -- @see :h 'concealcursor'
        concealcursor = {
          -- Used when not being rendered, get user setting.
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          -- Used when being rendered, disable concealing text in all modes.
          rendered = "",
        },
      },
    },
    -- ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    -- config = function(_, opts)
    --   require("render-markdown").setup(opts)
    --   Snacks.toggle({
    --     name = "Render Markdown",
    --     get = function()
    --       return require("render-markdown.state").enabled
    --     end,
    --     set = function(enabled)
    --       local m = require("render-markdown")
    --       if enabled then
    --         m.enable()
    --       else
    --         m.disable()
    --       end
    --     end,
    --   }):map("<leader>um")
    -- end,
  },
}
