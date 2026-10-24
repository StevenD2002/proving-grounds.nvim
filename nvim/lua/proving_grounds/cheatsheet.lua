-- <leader>? : show CHEATSHEET.md (repo root) in a centered floating window.
--
-- This is also the first example of the pattern every feature here follows:
-- plain functions on a table M, and a setup() that wires keymaps/autocmds.

local M = {}

-- ~/.config/nvim is a symlink to <repo>/nvim. Resolving it gives the real
-- path, and the cheatsheet sits one directory up, at the repo root.
local function cheatsheet_path()
  local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
  return vim.fs.joinpath(vim.fs.dirname(config_dir), "CHEATSHEET.md")
end

function M.open()
  local path = cheatsheet_path()
  if not vim.uv.fs_stat(path) then
    vim.notify("No cheatsheet at " .. path, vim.log.levels.WARN)
    return
  end

  -- A scratch buffer: not listed in :ls, no file behind it, wiped when hidden.
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(path))
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local width = math.min(100, math.floor(vim.o.columns * 0.8))
  local height = math.floor(vim.o.lines * 0.8)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    title = " cheatsheet — q to close ",
    title_pos = "center",
    -- no `border` key: it falls back to 'winborder' from options.lua
  })

  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, "<cmd>close<CR>", { buffer = buf, nowait = true })
  end
end

function M.setup()
  vim.keymap.set("n", "<leader>?", M.open, { desc = "Cheatsheet" })
end

return M
