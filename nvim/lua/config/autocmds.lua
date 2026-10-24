-- Autocommands: run code when an event happens.  :help autocmd-events
--
-- Every autocmd goes in an augroup created with { clear = true }. Re-sourcing
-- this file then REPLACES the autocmds instead of stacking duplicates, which
-- is the classic "why does this fire three times" bug.

local group = vim.api.nvim_create_augroup("proving_grounds_core", { clear = true })

-- Briefly flash whatever you just yanked, so you can see what `yi(` grabbed.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- When the terminal (or the herdr pane) is resized, rebalance Neovim's splits
-- instead of leaving one window squashed.
vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  desc = "Equalize splits on resize",
  command = "wincmd =",
})
