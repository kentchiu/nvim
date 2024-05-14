local IS_DEV = false

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = false,
        help = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      { "nvim-telescope/telescope.nvim" },
    },

    keys = {
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
      { "<leader>ac", "<cmd>CopilotChatReset<cr>", desc = "Clear And Reset" },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt actions",
      },
      {
        "<leader>ap",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "Prompt actions",
      },
    },

    opts = {
      -- See Configuration section for rest
      --
      debug = true, -- Enable debug logging
      -- proxy = nil, -- [protocol://]host[:port] Use this proxy
      -- allow_insecure = false, -- Allow insecure server connections
      --
      -- system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
      -- model = "gpt-4", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
      -- temperature = 0.1, -- GPT temperature
      --
      -- question_header = "## User ", -- Header to use for user questions
      -- answer_header = "## Copilot ", -- Header to use for AI answers
      -- error_header = "## Error ", -- Header to use for errors
      -- separator = "---", -- Separator to use in chat
      --
      -- show_folds = true, -- Shows folds for sections in chat
      -- show_help = true, -- Shows help message as virtual lines when waiting for user input
      -- auto_follow_cursor = true, -- Auto-follow cursor in chat
      -- auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
      -- clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
      --
      -- context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      -- history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
      -- callback = nil, -- Callback to use when ask response is received
      --
      -- default selection (visual or line)
      -- selection = function(source)
      --   -- return select.visual(source) or select.line(source)
      -- end,
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>a"] = { name = "AI" }
    end,
  },
}
