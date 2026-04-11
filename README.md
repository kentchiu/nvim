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


### Comparing against earlier commits

`diffthis` accepts any git revision. Always write the full form with the
`HEAD` prefix — never use the bare `~N` / `^N` shortcut that relies on
gitsigns auto-prepending `HEAD`.

```
:Gitsigns diffthis HEAD~       " one commit back (HEAD's parent)
:Gitsigns diffthis HEAD~1      " same as HEAD~
:Gitsigns diffthis HEAD~3      " three commits back
:Gitsigns diffthis HEAD^       " same as HEAD~ on linear history
:Gitsigns diffthis main        " vs main branch tip
:Gitsigns diffthis main~5      " main tip, five commits back
:Gitsigns diffthis v1.0.0      " vs a tag
:Gitsigns diffthis abc1234     " vs a commit SHA
```

#### `~` vs `^` — different operators

| Operator | Meaning                                         | Notes                                           |
| -------- | ----------------------------------------------- | ----------------------------------------------- |
| `~N`     | Walk back **N steps** along the first parent    | Use this for "N commits ago"                    |
| `^N`     | The commit's **Nth parent** (one step only)     | Only meaningful on merge commits with ≥N parents |

On a linear history (no merges) `HEAD^`, `HEAD~`, and `HEAD~1` are all
equivalent. The difference only matters on merge commits:

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

Rule of thumb: use `~N` to move back along the main line, use `^N` only
when you explicitly need to cross a merge into a specific parent branch.
For "diff against the commit before this one", write `HEAD~` or `HEAD~1`.

#### Chaining

Revision operators chain left-to-right. The left side can be any commit
reference (branch, tag, SHA, HEAD, or another `~`/`^` expression):

```
HEAD~2^2       " go back 2 steps on main, then take that commit's 2nd parent
HEAD^2~3       " take HEAD's 2nd parent, then walk back 3 steps
main~5         " main branch tip, 5 commits back
abc1234~       " the parent of commit abc1234
v1.0~1         " one commit before tag v1.0
```

To verify what a revision actually resolves to before using it:

```
git rev-parse HEAD~3              # prints the resolved SHA
git log --oneline HEAD~3 -1       # prints the commit message
```
