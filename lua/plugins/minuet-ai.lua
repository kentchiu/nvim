return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        -- notify = "verbose", -- see more notifications
        provider = "gemini",

        -- provider_options = {
        --   openai_compatible = {
        --     api_key = "GEMINI_API_KEY", -- will read the environment variable FIREWORKS_API_KEY
        --   },
        -- },
      })
    end,
  },
  {
    "Saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        ["<j-y>"] = {
          function(cmp)
            cmp.show({ providers = { "minuet" } })
          end,
        },
      },
      sources = {
        -- if you want to use auto-complete
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
        kind_icons = {
          -- LLM Provider icons
          claude = "󰋦",
          openai = "󱢆",
          codestral = "󱎥",
          gemini = "",
          Groq = "",
          Openrouter = "󱂇",
          Ollama = "󰳆",
          ["Llama.cpp"] = "󰳆",
          Deepseek = "",
        },
      },
      completion = {
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
              { "source_icon" },
            },
            components = {
              source_icon = {
                -- don't truncate source_icon
                ellipsis = false,
                text = function(ctx)
                  local source_icons = {
                    minuet = "󱗻",
                    orgmode = "",
                    otter = "󰼁",
                    nvim_lsp = "",
                    lsp = "",
                    buffer = "",
                    luasnip = "",
                    snippets = "",
                    path = "",
                    git = "",
                    tags = "",
                    cmdline = "󰘳",
                    latex_symbols = "",
                    cmp_nvim_r = "󰟔",
                    codeium = "󰩂",
                    -- FALLBACK
                    fallback = "󰜚",
                  }
                  return source_icons[ctx.source_name:lower()] or source_icons.fallback
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
      },
    },
  },
}
