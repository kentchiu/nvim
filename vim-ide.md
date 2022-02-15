# VIM As IDE



使用指令 ':verbose imap <tab>' 確定 tab 沒有被映射到其他插件

`:checkhealth` 在 neovim 可以輸入指令檢查

## COC Plugins

Lots of completion behavior can be changed by [using the configuration file](https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file), check out `:h coc-config-suggest` for details

查詢 coc extends help 方式是, `:CocList extensions` , 在 extansons list item 上按 <tab> 就會跳出相關的 actions, 選 help 即可.

###

檢查服務狀態

`g:coc_node_path` 啟動服務狀態前，要先配置 node 執行位置 配置到 .vimrc


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

## Windows KeyMap

### MOVING WINDOWS

```
CTRL+W r       -   Swap bottom/top if split horizontally
CTRL+W R       -   Swap top/bottom if split horizontally

CTRL+w r       -   Rotates the windows from left to right - only if the windows are split vertically
CTRL+w R       -   Rotates the windows from right to left - only if the windows are split vertically

CTRL+w H       -   Move current window the far left and use the full height of the screen
CTRL+w J       -   Move current window the far bottom and use the full width of the screen
CTRL+w K       -   Move current window the far top and full width of the screen
CTRL+w L       -   Move current window the far right and full height of the screen

```

### NAVIGATE BETWEEN WINDOWS

```
CTRL+w CTRL+w  -   switch between windows
CTRL+w UP      -   Move to the top window from current window
CTRL+w DOWN    -   Move to the bottom window from current window
CTRL+w LEFT    -   Move to the left window from current window
CTRL+w RIGHT   -   Move to the right window from current window
```
