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
      -- { "<leader>aC", "<cmd>CopilotChatCommit<cr>", desc = "Clear And Reset" },
      -- { "<leader>ad", "<cmd>CopilotChatDoc<cr>", desc = "Add Doc" },
      -- { "<leader>aD", "<cmd>CopilotChatDebugInfo<cr>", desc = "Add Doc" },
      -- { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      -- { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix" },
      -- { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
      -- { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Performance And Readbility" },
      -- { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      -- { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
      -- { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
      -- {
      --   "<leader>ah",
      --   function()
      --     local actions = require("CopilotChat.actions")
      --     print("🟥[1]: copilot.lua:62: actions=" .. vim.inspect(actions))
      --     require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      --     print("🟥[2]: copilot.lua:64: actions.help_actions()=" .. vim.inspect(actions.help_actions()))
      --   end,
      --   desc = "Help actions",
      -- },
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
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections

      system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
      model = "gpt-4", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
      temperature = 0.1, -- GPT temperature

      question_header = "## User ", -- Header to use for user questions
      answer_header = "## Copilot ", -- Header to use for AI answers
      error_header = "## Error ", -- Header to use for errors
      separator = "---", -- Separator to use in chat

      show_folds = true, -- Shows folds for sections in chat
      show_help = true, -- Shows help message as virtual lines when waiting for user input
      auto_follow_cursor = true, -- Auto-follow cursor in chat
      auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
      clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

      context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
      callback = nil, -- Callback to use when ask response is received

      -- default selection (visual or line)
      -- selection = function(source)
      --   print("🟥[1]: copilot.lua:70: source=" .. vim.inspect(source))
      --   -- return select.visual(source) or select.line(source)
      -- end,

      -- default prompts
      -- prompts = {
      --   Explain = {
      --     prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
      --   },
      --   Review = {
      --     prompt = "/COPILOT_REVIEW Review the selected code.",
      --     callback = function(response, source)
      --       -- see config.lua for implementation
      --     end,
      --   },
      --   Fix = {
      --     prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
      --   },
      --   Optimize = {
      --     prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
      --   },
      --   Docs = {
      --     prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
      --   },
      --   Tests = {
      --     prompt = "/COPILOT_GENERATE Please generate tests for my code.",
      --   },
      --   FixDiagnostic = {
      --     prompt = "Please assist with the following diagnostic issue in file:",
      --     selection = select.diagnostics,
      --   },
      --   Commit = {
      --     prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
      --     selection = select.gitdiff,
      --   },
      --   CommitStaged = {
      --     prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
      --     selection = function(source)
      --       return select.gitdiff(source, true)
      --     end,
      --   },
      -- },

      -- default window options
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
        border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = "Copilot Chat", -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },

      -- default mappings
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-m>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --     { "nvim-telescope/telescope.nvim" },
  --   },
  --   opts = {
  --     question_header = "## User ",
  --     answer_header = "## Copilot ",
  --     error_header = "## Error ",
  --     separator = " ", -- Separator to use in chat
  --     prompts = prompts,
  --     auto_follow_cursor = false, -- Don't follow the cursor after getting response
  --     show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
  --     mappings = {
  --       -- Use tab for completion
  --       complete = {
  --         detail = "Use @<Tab> or /<Tab> for options.",
  --         insert = "<Tab>",
  --       },
  --       -- Close the chat
  --       close = {
  --         normal = "q",
  --         insert = "<C-c>",
  --       },
  --       -- Reset the chat buffer
  --       reset = {
  --         normal = "<C-l>",
  --         insert = "<C-l>",
  --       },
  --       -- Submit the prompt to Copilot
  --       submit_prompt = {
  --         normal = "<CR>",
  --         insert = "<C-CR>",
  --       },
  --       -- Accept the diff
  --       accept_diff = {
  --         normal = "<C-y>",
  --         insert = "<C-y>",
  --       },
  --       -- Show the diff
  --       show_diff = {
  --         normal = "gmd",
  --       },
  --       -- Show the prompt
  --       show_system_prompt = {
  --         normal = "gmp",
  --       },
  --       -- Show the user selection
  --       show_user_selection = {
  --         normal = "gms",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     local chat = require("CopilotChat")
  --     local select = require("CopilotChat.select")
  --     -- Use unnamed register for the selection
  --     opts.selection = select.unnamed
  --
  --     -- Override the git prompts message
  --     opts.prompts.Commit = {
  --       prompt = "Write commit message for the change with commitizen convention",
  --       selection = select.gitdiff,
  --     }
  --     opts.prompts.CommitStaged = {
  --       prompt = "Write commit message for the change with commitizen convention",
  --       selection = function(source)
  --         return select.gitdiff(source, true)
  --       end,
  --     }
  --
  --     chat.setup(opts)
  --
  --     vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
  --       chat.ask(args.args, { selection = select.visual })
  --     end, { nargs = "*", range = true })
  --
  --     -- Inline chat with Copilot
  --     vim.api.nvim_create_user_command("CopilotChatInline", function(args)
  --       chat.ask(args.args, {
  --         selection = select.visual,
  --         window = {
  --           layout = "float",
  --           relative = "cursor",
  --           width = 1,
  --           height = 0.4,
  --           row = 1,
  --         },
  --       })
  --     end, { nargs = "*", range = true })
  --
  --     -- Restore CopilotChatBuffer
  --     vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
  --       chat.ask(args.args, { selection = select.buffer })
  --     end, { nargs = "*", range = true })
  --
  --     -- Custom buffer for CopilotChat
  --     vim.api.nvim_create_autocmd("BufEnter", {
  --       pattern = "copilot-*",
  --       callback = function()
  --         vim.opt_local.relativenumber = true
  --         vim.opt_local.number = true
  --
  --         -- Get current filetype and set it to markdown if the current filetype is copilot-chat
  --         local ft = vim.bo.filetype
  --         if ft == "copilot-chat" then
  --           vim.bo.filetype = "markdown"
  --         end
  --       end,
  --     })
  --   end,
  --   event = "VeryLazy",
  --   keys = {
  --     -- Show help actions with telescope
  --     {
  --       "<leader>ah",
  --       function()
  --         local actions = require("CopilotChat.actions")
  --         require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  --       end,
  --       desc = "Help actions",
  --     },
  --     -- Show prompts actions with telescope
  --     {
  --       "<leader>ap",
  --       function()
  --         local actions = require("CopilotChat.actions")
  --         require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  --       end,
  --       desc = "Prompt actions",
  --     },
  --     {
  --       "<leader>ap",
  --       ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
  --       mode = "x",
  --       desc = "Prompt actions",
  --     },
  --     -- Code related commands
  --     { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
  --     { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
  --     { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
  --     { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
  --     { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
  --     -- Chat with Copilot in visual mode
  --     {
  --       "<leader>av",
  --       ":CopilotChatVisual",
  --       mode = "x",
  --       desc = "Open in vertical split",
  --     },
  --     {
  --       "<leader>ax",
  --       ":CopilotChatInline<cr>",
  --       mode = "x",
  --       desc = "Inline chat",
  --     },
  --     -- Custom input for CopilotChat
  --     {
  --       "<leader>ai",
  --       function()
  --         local input = vim.fn.input("Ask Copilot: ")
  --         if input ~= "" then
  --           vim.cmd("CopilotChat " .. input)
  --         end
  --       end,
  --       desc = "Ask input",
  --     },
  --     -- Generate commit message based on the git diff
  --     {
  --       "<leader>am",
  --       "<cmd>CopilotChatCommit<cr>",
  --       desc = "Generate commit message for all changes",
  --     },
  --     {
  --       "<leader>aM",
  --       "<cmd>CopilotChatCommitStaged<cr>",
  --       desc = "Generate commit message for staged changes",
  --     },
  --     -- Quick chat with Copilot
  --     {
  --       "<leader>aq",
  --       function()
  --         local input = vim.fn.input("Quick Chat: ")
  --         if input ~= "" then
  --           vim.cmd("CopilotChatBuffer " .. input)
  --         end
  --       end,
  --       desc = "Quick chat",
  --     },
  --     -- Debug
  --     { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
  --     -- Fix the issue with diagnostic
  --     { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
  --     -- Clear buffer and chat history
  --     { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
  --     -- Toggle Copilot Chat Vsplit
  --     { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
  --   },
  -- },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>a"] = { name = "AI" }
      -- opts.defaults["<leader>aa"] = { name = "copilot chat" }
    end,
  },
}
