return {
  {
    'kentchiu/gemini.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      api_key = os.getenv('GOOGLE_API_KEY'),
      locale = 'zh_TW',
      alternate_locale = 'en',
    },
    cmd = { 'GeminiDefine', 'GeminiDefineV', 'GeminiTranslate', 'GeminiAsk' },
  },
}
