return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "/home/kent/get_api_key.sh",
        openai_params = {
          model = "gpt-4",
        },
        actions_paths = {
        },
      })
    end,
  }
}

