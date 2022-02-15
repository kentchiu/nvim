# VIM As IDE



使用指令 ':verbose imap <tab>' 確定 tab 沒有被映射到其他插件

## COC Plugins


###

檢查服務狀態

`g:coc_node_path` 啟動服務狀態前，要先配置 node 執行位置 配置到 .vimrc

`:checkhealth` 在 neovim 可以輸入指令檢查

`:CocInfo` 使用此指令查看服務資訊 vim 可以用這個指令檢查服務狀態

###

安裝擴充功能

`:CocInstall {name}` 安裝擴充功能指令

`:CocInstall coc-json` 首先安裝 coc-json，在設定 coc 時，是使用 json 格式

安裝其他擴充功能，可以到 npm 網站搜尋 [https://www.npmjs.com/search?q=keywords%3Acoc.nvim](https://www.npmjs.com/search?q=keywords%3Acoc.nvim)​

`:CocUninstall {name}` 解除安裝擴充指令

`:CocUpdate` 升級所有擴充，升級前請確保確保coc為最新版本 例如如果是用 vim-plug 就用此插件的更新指令 `:PlugUpdate`


- `gd`: go to definition
- <C> + o : go back to last position


