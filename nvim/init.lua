-- proving-grounds.nvim — entry point
--
-- This file only decides ORDER. Every piece of real configuration lives in its
-- own module under lua/, so you can read (and break) one thing at a time.
--
-- Neovim finds Lua modules under lua/ on the 'runtimepath':
--   require("config.options")  ->  lua/config/options.lua

-- Byte-compiles and caches every required Lua module. Pure startup speed.
-- If a change to a module ever seems "ignored", this is the first suspect:
-- comment it out to rule it out.  :help vim.loader
vim.loader.enable()

-- Leader keys MUST be set before any mapping that uses <leader> is defined:
-- a mapping captures the value of <leader> when it's created, not when used.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options") -- editor behaviour (:set ...)
require("config.keymaps") -- our own mappings; see CHEATSHEET.md
require("config.autocmds") -- things that happen on events
require("config.plugins") -- loads every file in lua/plugins/ (empty in Phase 0)

-- Home-grown features (trust levels, focus marks, cheatsheet, ...).
require("proving_grounds").setup()
