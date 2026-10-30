# Cheatsheet

`<leader>` = `Space`. Open this in nvim with `Space ?`. Close it with `q`.
Rule: a commit that changes a keymap updates this file too.

## Ours

| Keys | Mode | Does |
|---|---|---|
| `jk` | i | leave insert mode |
| `Esc` | n | clear search highlight |
| `Space ?` | n | this cheatsheet |
| `Ctrl-h/j/k/l` | n | move between nvim windows |
| `Space f f` | n | open up the file search menu |
| `Space g g` | n | open up the git menu |

## herdr panes (Alt = left Option)

| Keys | Does |
|---|---|
| `Alt h/j/k/l` | focus pane left / down / up / right |
| `Alt t` | zoom the focused pane (toggle) |
| `Alt v` / `Alt -` | split right / split down |
| `Ctrl-b` then `h/j/k/l/z/v/-` | the same actions via herdr's prefix (fallback) |

## Built-ins worth getting back into your fingers

These come with Neovim, so there's nothing to install. Learning them is the point.

### Moving
| Keys | Does |
|---|---|
| `w` `b` `e` / `W` `B` `E` | word forward/back/end (capital = WORD, splits on whitespace only) |
| `f{c}` `t{c}` / `F` `T` | jump to / just before char `{c}` on this line |
| `%` | jump to matching bracket |
| `{` `}` | previous / next blank line (paragraph) |
| `Ctrl-d` `Ctrl-u` | half page down / up |
| `gg` `G` / `{n}G` | top / bottom / line n |
| `*` `#` | search word under cursor forward / back |
| `Ctrl-o` `Ctrl-i` | jump back / forward through the jump list |
| `` `. `` | jump to the last change |

### Editing: verb + text object
`d` delete, `c` change, `y` yank, `v` select, then `i`nside or `a`round:
`w` word, `"` `'` `` ` `` quotes, `(` `[` `{` `<` brackets, `t` tag, `p` paragraph.
Examples: `ci"` change inside quotes, `da(` delete parens and contents, `yap` yank paragraph.

| Keys | Does |
|---|---|
| `.` | repeat last change, the most underrated key in Vim |
| `u` / `Ctrl-r` | undo / redo |
| `>>` `<<` | indent / dedent line |
| `gcc` / `gc{motion}` | toggle comment on line / over motion |
| `J` | join line below onto this one |
| `~` | toggle case |
| `qa … q` then `@a` | record macro into `a`, replay it (`@@` repeats) |

### Windows & buffers
| Keys | Does |
|---|---|
| `Ctrl-w v` / `Ctrl-w s` | split vertical / horizontal |
| `Ctrl-w h/j/k/l` | move between splits |
| `Ctrl-w =` | equalize splits |
| `Ctrl-^` | toggle to the alternate (previous) buffer |
| `:ls` / `:b {name}` | list buffers / switch by partial name |

### LSP: active once Phase 3 attaches a language server
| Keys | Does |
|---|---|
| `K` | hover docs |
| `grn` | rename symbol |
| `gra` | code action |
| `grr` | references |
| `gri` | implementation |
| `grt` | type definition |
| `gO` | document symbols |
| `[d` `]d` | previous / next diagnostic |
| `Ctrl-w d` | diagnostic under cursor in a float |
| `Ctrl-s` (insert) | signature help |

### Getting unstuck
| Command | Does |
|---|---|
| `:help {thing}` | the manual, which is genuinely good. `:help` then `Ctrl-]` follows links |
| `:verbose map {keys}` | what a key is mapped to and which file did it |
| `:checkhealth` | diagnose setup problems |
| `:messages` | messages that flashed by |
