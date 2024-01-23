return {
  {
    'kentchiu/gemini.nvim',
    enabled = false,
    opts = {
      api_key = os.getenv('GOOGLE_API_KEY'),
      locale = 'en',
      alternate_locale = 'zh_TW',
      prompts = {
        complete = {
          command = 'GeminiComplete',
          loading_tpl = 'Completeing...',
          prompt_tpl =
          'Complete the following code written by pasting the existing code and continuing it.\n\nExisting code:\n```${input}\n```\n\n',
          result_tpl = '```\n${output}```',
          require_input = true,
        },
        rock = {
          command = 'GeminiRock',
          loading_tpl = 'Loading...',
          prompt_tpl = 'hi',
          result_tpl = 'Here is your joke:\n\n${output}',
          require_input = false,
        },
        define = {
          command = 'GeminiDefine',
          loading_tpl = 'Define:\n\n${input}\n\nAsking Gemini...',
          prompt_tpl =
          'Define the content below in locale ${locale}. The output is a bullet list of definitions grouped by parts of speech in plain text. Each item of the definition list contains pronunciation using IPA, meaning, and a list of usage examples with at most 2 items. Do not return anything else. Here is the content:\n\n${input_encoded}',
          result_tpl = 'Original Content:\n\n${input}\n\nDefinition:\n\n${output}',
          require_input = true,
        },
        translate = {
          command = 'GeminiTranslate',
          loading_tpl = 'Translating the content below:\n\n${input}\n\nAsking Gemini...',
          prompt_tpl =
          'Translate the content below into locale ${locale}. Translate into ${alternate_locale} instead if it is already in ${locale}. Do not return anything else. Here is the content:\n\n${input_encoded}',
          result_tpl = 'Original Content:\n\n${input}\n\nTranslation:\n\n${output}',
          require_input = true,
        },
        improve = {
          command = 'GeminiImprove',
          loading_tpl = 'Improve the content below:\n\n${input}\n\nAsking Gemini...',
          prompt_tpl =
          'Improve the content below in the same locale. Do not return anything else. Here is the content:\n\n${input_encoded}',
          result_tpl = 'Original Content:\n\n${input}\n\nImproved Content:\n\n${output}',
          require_input = true,
        },
        freeStyle = {
          command = 'GeminiAsk',
          loading_tpl = 'Question:\n\n${input}\n\nAsking Gemini...',
          prompt_tpl = '${input}',
          result_tpl = 'Question:\n\n${input}\n\nAnswer:\n\n${output}',
          require_input = true,
        },
      }
    },
    cmd = { 'GeminiDefine', 'GeminiDefineV', 'GeminiTranslate', 'GeminiAsk' },
    event = 'VeryLazy'
  },
}
