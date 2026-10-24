-- Editor options. Everything here is equivalent to a `:set` command.
-- To learn what any option does:  :help 'optionname'   (quotes included)
-- To see its current value:       :set optionname?
--
-- vim.o is the simple interface (strings, numbers, booleans).
-- vim.opt is the richer one for list/map options (:append(), :remove()).

local o = vim.o

-- Line numbers --------------------------------------------------------------
-- Relative numbers make counts visible: the line 7 below is labelled "7", so
-- `7j`, `d7k`, `y3j` become things you read off the screen instead of guess.
o.number = true -- absolute number on the cursor line
o.relativenumber = true -- relative numbers everywhere else

-- Layout --------------------------------------------------------------------
o.signcolumn = "yes" -- always reserve the sign column: no text jitter when
--                      git/diagnostic signs appear later (Phase 3/4)
o.cursorline = true -- highlight the line the cursor is on
o.scrolloff = 8 -- keep 8 lines of context above/below the cursor
o.sidescrolloff = 8
o.wrap = false -- long lines scroll horizontally instead of wrapping
o.laststatus = 3 -- one global statusline instead of one per window
o.winborder = "rounded" -- default border for every floating window (0.11+)

-- Splits --------------------------------------------------------------------
o.splitright = true -- :vsplit opens to the right
o.splitbelow = true -- :split opens below
o.splitkeep = "screen" -- text doesn't jump when a split opens/closes

-- Searching -----------------------------------------------------------------
o.ignorecase = true -- /foo matches Foo ...
o.smartcase = true -- ... unless the pattern has a capital: /Foo is exact
o.inccommand = "split" -- live preview of :s/// in a split, before you commit

-- Indentation ---------------------------------------------------------------
-- Defaults only. Per-project .editorconfig files override these (built in),
-- and Phase 3 formatters (gofumpt uses tabs, rustfmt 4 spaces) fix the rest on save.
o.expandtab = true -- <Tab> inserts spaces
o.shiftwidth = 2 -- >> and auto-indent use 2 spaces
o.tabstop = 2 -- a literal tab character displays as 2 columns
o.smartindent = true

-- Whitespace you can't otherwise see ----------------------------------------
o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Files & history -----------------------------------------------------------
o.undofile = true -- undo history survives closing the file (you already
--                   have years of it in ~/.local/state/nvim/undo)
o.confirm = true -- :q on a modified buffer asks instead of erroring
o.swapfile = true -- crash recovery (default; written out so you know it exists)

-- Timing --------------------------------------------------------------------
o.updatetime = 250 -- ms of idle before CursorHold fires (LSP highlights, etc.)
o.timeoutlen = 400 -- ms to wait for the next key of a mapping like `jk`

-- Clipboard -----------------------------------------------------------------
-- Deliberately NOT synced with the macOS clipboard. Use "+y / "+p when you
-- mean the system clipboard; plain y/d/p stay inside nvim, so `dd` never
-- clobbers what you copied elsewhere.  :help 'clipboard'  :help quote+

-- Mode indicator ------------------------------------------------------------
-- false, we have a custom status line now
o.showmode = false
