-- Our own keymaps. Rule: any change here also changes CHEATSHEET.md.
--
-- vim.keymap.set(mode, lhs, rhs, opts)
--   mode: "n" normal, "i" insert, "v" visual+select, "x" visual only, "t" terminal
--   lhs:  the keys you press
--   rhs:  a string of keys/command, OR a Lua function
--   desc: shows up in which-key (Phase 2) and in :map listings
--
-- Before adding a mapping, check what you're about to shadow:
--   :verbose map <lhs>      (who mapped it, and where)
--   :help <lhs>             (what Vim does with it by default)

local map = vim.keymap.set

-- `jk` typed quickly in insert mode leaves insert mode. 'timeoutlen' (in
-- options.lua) is how long Neovim waits after `j` to see if `k` follows.
map("i", "jk", "<Esc>", { desc = "Leave insert mode" })

-- Small quality-of-life -------------------------------------------------------
-- After a search, matches stay highlighted. <Esc> in normal mode clears them.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Windows ---------------------------------------------------------------------
-- Ctrl+hjkl moves between nvim windows (splits); Alt+hjkl is herdr panes.
-- Shadows the default Ctrl-L (redraw); :redraw! still does that.
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
