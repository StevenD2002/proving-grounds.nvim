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

-- Carried over from the NvChad config ----------------------------------------
-- `;` normally repeats the last f/t/F/T motion, and `,` repeats it backwards.
-- This mapping gives that up in exchange for one less Shift on every command.
-- Worth revisiting once f/t motions are back in your fingers.
map({ "n", "x" }, ";", ":", { desc = "Command-line" })

-- `jk` typed quickly in insert mode leaves insert mode. 'timeoutlen' (in
-- options.lua) is how long Neovim waits after `j` to see if `k` follows.
map("i", "jk", "<Esc>", { desc = "Leave insert mode" })

-- Small quality-of-life -------------------------------------------------------
-- After a search, matches stay highlighted. <Esc> in normal mode clears them.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
