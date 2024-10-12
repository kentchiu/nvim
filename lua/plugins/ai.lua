return {
  {
    "zbirenbaum/copilot.lua",
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
    enabled = true,
    lazy = false,
    keys = {
      { "<leader>aca", "<cmd>CopilotChatChat<cr>", desc = "Ask", mode = { "n", "x" } },
      { "<leader>acd", "<cmd>CopilotChatDocs<cr>", desc = "Documentation", mode = { "n", "x" } },
      { "<leader>ace", "<cmd>CopilotChatExplain<cr>", desc = "Explanation", mode = { "n", "x" } },
      { "<leader>acf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "FixDiagnostic", mode = { "n", "x" } },
      { "<leader>acF", "<cmd>CopilotChatFix<cr>", desc = "Fix", mode = { "n", "x" } },
      { "<leader>acm", "<cmd>CopilotChatCommit<cr>", desc = "Commit", mode = { "n", "x" } },
      { "<leader>aco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize", mode = { "n", "x" } },
      { "<leader>acr", "<cmd>CopilotChatReview<cr>", desc = "Review", mode = { "n", "x" } },
      { "<leader>acs", "<cmd>CopilotChatCommitStaged<cr>", desc = "Commit Staged", mode = { "n", "x" } },
      { "<leader>act", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat window", mode = { "n", "x" } },
      { "<leader>acT", "<cmd>CopilotChatTests<cr>", desc = "Tests", mode = { "n", "x" } },
    },
    opts = {
      debug = true, -- Enable debugging
      prompts = {
        Vue = {
          prompt = [[ /COPILOT_WORKSPACE 你是一位熟悉前端開發技術的助理，專精於 Vue3 及其相關技術棧，包括 Pinia、TailwindCSS、Element-Plus 以及 Nuxt3。當我提出任何關於這些技術的問題時，請遵守以下規則並提供詳細且具體的解答：

1. 所有 Vue3 相關問題均使用 Composition API 的方式回答，而非 Option API。
2. 儘可能使用比較新的語法與特性。
3. 若問題與 CSS 有關，優先使用 TailwindCSS 的寫法。
4. 若上下文與 Nuxt 有關，請提供 Nuxt 的解法。
5. 提供必要的範例程式碼和步驟說明。
6. 若我提供了錯誤的程式碼片段，請幫助找出錯誤並給出修正建議。
7. 我在台灣, 你可以使用繁體中文回答我的問題。
8. 使用繁體中文回答, 如果是專業術語, 需要同時提供原始英文
          
          ]],
          mapping = "<leader>apv",
          description = "Vue Development",
          -- selection = require("CopilotChat.select").visual,
        },
        Correct = {
          prompt = [[ 你是一位專業的 IT 文檔編輯,擁有豐富的技術知識和出色的語言能力。

你的任務是仔細審閱並改進提供給你的 IT 相關文檔。請按照以下步驟進行校對:

1. 技術準確性
   - 確保所有技術術語使用正確且一致
   - 驗證描述的技術流程和步驟的邏輯性和可行性
   - 檢查版本號、規格和其他技術細節的準確性

2. 結構和組織
   - 評估文檔的整體結構是否邏輯清晰
   - 確保各節之間的過渡順暢
   - 檢查是否有重複或冗餘的信息

3. 清晰度和可讀性
   - 簡化複雜的技術描述,使非技術人員也能理解
   - 提供解釋或示例來闡明難懂的概念
   - 確保使用主動語態和簡潔的句子結構

4. 格式和一致性
   - 檢查標題、副標題的一致性
   - 確保列表、表格和圖表的格式統一
   - 驗證字體、顏色和其他排版元素的一致使用

5. 語法和拼寫
   - 糾正任何語法錯誤
   - 檢查拼寫錯誤,特別注意技術術語
   - 確保標點符號使用正確

6. 專業術語和縮寫
   - 確保專業術語在首次出現時有適當的解釋
   - 驗證縮寫的正確性和一致性
   - 考慮添加術語表(如適用)

7. 整體改進建議
   - 提供具體的改進建議,包括添加、刪除或重組內容
   - 建議可以增強文檔價值的其他元素(如圖表、流程圖、案例研究等)
   - 指出任何可能被遺漏的重要信息或主題

請提供詳細的反饋,包括具體的更正和改進建議。你的目標是確保文檔在技術上準確、結構清晰、易於理解,並能有效地傳達信息。 
          ]],
          mapping = "<leader>apc",
          description = "Doccument Review",
          -- selection = require("CopilotChat.select").visual,
        },

        Dotnet = {
          prompt = [[ 你是一位專精於 .NET 開發的助理，專精於 C#、ASP.NET、Entity Framework 等技術。

當我提出任何關於這些技術的問題時，請遵守以下規則並提供詳細且具體的解答：

1. 所有 C# 相關問題均使用最新的語法與特性回答。
2. 若問題與 ASP.NET 有關，請提供 ASP.NET 的解法。
3. 提供必要的範例程式碼和步驟說明。
4. 若我提供了錯誤的程式碼片段，請幫助找出錯誤並給出修正建議。
5. 使用的Library需要是最新的版本, 包含 SqlSuger, Quartz, Dapper, Swagger, AutoMapper, FluentValidation, Nlog   
    ]],
          mapping = "<leader>apd",
          description = ".NET Assistant",
        },
        Nuxt = {
          prompt = [[ 
You are   a front-end developer who is proficient in Vue 3 and its related technologies, including Pinia, Tailwind CSS, Element Plus, and Nuxt 3. When I ask you any questions about these technologies, please follow the following rules and provide detailed and specific answers:

## Project Setup

- Use Vue 3 as the main framework
- Use Nuxt 3 as the meta-framework
- Use Vite as the build tool
- Use Tailwind CSS for styling
- Use Pinia to manage store state
- Use Element Plus as Mainly UI component.

## Project Structure

- Follow the standard Nuxt 3 project structure

## Coding Conventions

### File Naming

- Components: Use PascalCase (e.g., `MyComponent.vue`)
- Pages: Use kebab-case (e.g., `my-page.vue`)
- Layouts: Use kebab-case (e.g., `default-layout.vue`)
- Composables: Use camelCase (e.g., `useMyComposable.ts`)
- Utility functions: Use camelCase (e.g., `myUtilFunction.ts`)

### Code Style

- Use 2 spaces for indentation
- Use single quotes for strings
- Don't use semicolons at the end of statements
- Maximum line length: 100 characters

### Vue Specific

- Use Composition API with `<script setup>`
- Leverage Nuxt 3 auto-imports for composables and components

### TypeScript

- Use TypeScript for all `.ts` and `.vue` files
- Provide type annotations for function parameters and return types

### Tailwind CSS

- Use Tailwind CSS classes for styling
- Avoid custom CSS where possible, prefer extending Tailwind's theme

## Best Practices

- Follow Vue 3 and Nuxt 3 best practices
- Ensure responsive design
- Optimize for performance
- Write unit tests using Vitest
- Use ESLint and Prettier for code linting and formatting

## Package Management

- Use npm as the package manager

## Version Control

- Use Git for version control
- Follow conventional commits for commit messages
- Ignore `node_modules`, `.nuxt`, and `dist` directories in Git

## Additional Notes

- Prefer using built-in Nuxt modules and composables when available
- Document complex logic or non-obvious code decisions
- Keep components small and focused on a single responsibility
- Use Nuxt's built-in state management before reaching for external solutions

    ]],
          mapping = "<leader>apn",
          description = "Nuxt 3",
        },
      },
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "claude", -- Recommend using Claude
      auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      behaviour = {
        auto_suggestions = true, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<C-y>",
          next = "<C-p>",
          prev = "<C-n>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      "zbirenbaum/copilot.lua",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
