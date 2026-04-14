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

## 常見的 built-in prefix

| Prefix              | 用途                                                                         |
| ------------------- | ---------------------------------------------------------------------------- |
| `g`                 | 擴充指令（`gg` `gd` `gf` `gx` `gq` `gu`/`gU` `g;` `g,` `gv` `g~`）           |
| `z`                 | 視窗捲動 / fold / spell（`zz` `zt` `zb` `za` `zo` `zc` `zR` `zM` `zg` `z=`） |
| `CTRL-W`            | 視窗操作（切換、分割、調大小、關閉）                                         |
| `CTRL-X`            | insert mode 補全（`CTRL-X CTRL-F/O/N/L`）                                    |
| `CTRL-R`            | insert/cmdline 貼暫存器；normal 為 redo                                      |
| `[` / `]`           | 配對跳躍（`[c` `]c` diff、`[m` `]m` method、`[{` `]}`、`[d` `]d`）           |
| `"`                 | 指定暫存器（`"ay` `"+p`）                                                    |
| `@`                 | 執行 macro / 暫存器                                                          |
| `q`                 | 錄製 macro（`qa` … `q`）                                                     |
| `m` / `` ` `` / `'` | mark 與跳回                                                                  |
| `Z`                 | 快速離開（`ZZ` `ZQ`）                                                        |
| `CTRL-G`            | 顯示檔案資訊                                                                 |

> `g<`: focus on ui2 window

## Mark

### 設 mark

| 指令      | 範圍                 | 備註                    |
| --------- | -------------------- | ----------------------- |
| `m{a-z}`  | buffer-local         | 只在當前檔案有效        |
| `m{A-Z}`  | global               | 跨檔案，記住檔案路徑    |
| `m{0-9}`  | Vim 自動維護         | 不要手動設              |

### 跳回 mark


```text
反引號  `  = 精確位置（行 + 欄），單引號 ' = 該行開頭（first non-ws）。
`a      跳到 mark a 的精確位置
'a      跳到 mark a 那一行的開頭

``      跳回上次跳躍前的位置
`.      最後一次編輯的位置
`^      最後一次離開 insert mode 的位置
`[  `]  最後一次 yank / change 的開頭 / 結尾
`<  `>  最後一次 visual 選取的開頭 / 結尾
```

### 常用場景

**暫存位置跳回**

```
ma        ← 記下這個位置
{一堆跳躍}
`a        ← 回來
```

**跨檔案重要位置**

```
mE        在某個檔案某行設 global mark E (Entry)
（切到別的 buffer）
`E        直接跳回去（連檔案一起切）
```

**配合 operator**

```
ma        設 mark
{移動到另一處}
d`a       刪除從這裡到 mark a（精確位置）
y'a       yank 從這行到 mark a 那一行（整行）
```

### 檢視與清除

```vim
:marks          看所有 mark
:marks aA       看指定 mark
:delmarks a     刪 mark a
:delmarks!      刪所有 buffer-local mark（a-z）
```

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

## oil 當做 SFTP Client

用 ssh 的方式開啟遠端 server:

```bash
nvim oil-ssh://[username@]hostname[:port]/[path]
:edit oil-ssh://ssh-config-name/
```

在 nvim 裡再開啟一個 oil window:

```vim
:Oil .
```

兩個 window 就可以互相操作了, 用 `CTRL-W w` (switch to other window) 切換

可以把 Remote File copy 會本機


## MISC


