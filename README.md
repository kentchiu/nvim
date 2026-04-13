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
- v_]n - select prev node
- v_[n - select next node


## Difftool

```
gh pr checkout 123
git difftool -d main
```


## Git Diff (current buffer)

Powered by `gitsigns.nvim`. Opens a vertical split in native Neovim diff mode,
so `diffopt` options (e.g. `inline:char`, `linematch`) are respected.

| Keymap        | Compares against | What you see                                   |
| ------------- | ---------------- | ---------------------------------------------- |
| `<leader>di`  | index            | Unstaged changes only                          |
| `<leader>dh`  | HEAD             | All uncommitted changes (staged + unstaged)    |
| `<leader>dt`  | —                | Toggle inline display of deleted lines         |


### `~` vs `^` — different operators

```
       A ── B ── C         ← feature
      /          \
··· X ── Y ── Z ── M        ← main, HEAD = M
```

- `M~1` = `M^1` = `M^` = **Z**  (first parent, main line)
- `M~2` = `Z^` = **Y**           (two steps along main line)
- `M~3` = **X**
- `M^2` = **C**                  (second parent — the merged branch)
- `M^3` = error (M has only 2 parents)


## MISC

- `g<`: focus on ui2 window
