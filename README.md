## New defaults and built-in mappings

- gra → code actions
- gri → implementations
- grn → rename
- grr → references
- grt → type definition
- grx → run codelens
- gO → document symbols
- Ctrl-S in Insert mode → signature help

## Incremental Selection

- v_an - select parent node
- v_in - select child node
- v\_]n - select prev node
- v\_[n - select next node

## Diff

所有 diff view 都用 native Neovim diff mode（respect `diffopt`:
`inline:char`, `linematch` 等）。Layout 一律是 **ref 在左（readonly），
working tree 在右（editable）**，跟 `git diff` 和 code review 工具一致。

| Keymap       | 範圍   | 使用情境                                                                             |
| ------------ | ------ | ------------------------------------------------------------------------------------ |
| `<leader>di` | Buffer | 編輯中想看「這個檔案還沒 stage 的改動」                                              |
| `<leader>dh` | Buffer | 編輯中想看「這個檔案相對最後一次 commit 改了什麼」（最常用）                         |
| `<leader>dc` | Buffer | 想知道「這個檔案在某個 branch/tag/commit 當時長什麼樣」，例如對照半年前的版本        |
| `<leader>db` | Buffer | 查這個檔案歷代被誰改過、什麼時候改、改了什麼(file history)                           |
| `<leader>dt` | Buffer | 看當前 hunk 被刪掉的那幾行(inline 顯示)                                              |
| `<leader>dd` | Folder | 看「整個專案相對某個 ref 差多少」— 例如 cherry-pick 前看差異、對照某個 release tag   |
| `<leader>dm` | Folder | Review 自己 feature branch / PR — 只看「這個 branch 加了什麼」，排除 base 推進的雜訊 |
| `<leader>dp` | Folder | 查某個目錄(例如 `src/auth/`)的演進歷史，看所有影響它的 commits                       |

實務流程：

- **寫 code 中** → `dh`（看當前變更）、`di`（看未 stage）
- **挖歷史** → `db`（單檔歷史）、`dp`（目錄歷史）、`dc`（挑時間點比）
- **Review 整體** → `dd`（跟某 ref 全比）、`dm`（PR 範圍）

`dd` / `dm` 的 quickfix list 會用 `[new]` / `[del]` / `[mod]` 標示狀態，
按 Enter 開啟該檔案的 diff split。

Ref vs ref（兩邊都 readonly）的情境，直接用 git：

```
git difftool -d main..feature/xxx
```

## MISC

- `g<`: focus on ui2 window

## oil 當做 SFTP Client

用 ssh 的方式開啟遠端 server:

```bash
nvim oil-ssh://[username@]hostname[:port]/[path]
```

在 nvim 裡再開啟一個 oil window:

```vim
:Oil .
```

兩個 window 就可以互相操作了, 用 `<leader>ww` (switch to other window) 切換

可以把 Remote File copy 會本機

### Bellwin

`:edit oil-ssh://bellwin/`

或從家目錄開始：

`:edit oil-ssh://bellwin/~/`
