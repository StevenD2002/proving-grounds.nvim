-- Our own statusline. Later phases add segments here: git branch (Phase 4),
-- trust level (Phase 5), local model status (Phase 6), review quota (Phase 8).
--
-- How it works: 'statusline' is set to "%!<expression>". Neovim evaluates the
-- expression on every redraw and uses the returned STRING as the statusline.
-- That string can contain statusline codes:  :help 'statusline'
--   %f  file path      %m  [+] if modified   %r  [RO] if read-only
--   %=  push the rest to the right            %l:%c  line:column
--   %#Group#  switch to highlight group        %*  back to the default group

local M = {}

-- Mode name + highlight group, keyed by the FIRST character of the mode
-- string from vim.api.nvim_get_mode().mode  (:help mode()).
-- "\22" is Ctrl-V, the character Neovim reports for visual-block mode.
local modes = {
  n = { "NORMAL", "PGModeNormal" },
  i = { "INSERT", "PGModeInsert" },
  v = { "VISUAL", "PGModeVisual" },
  V = { "V-LINE", "PGModeVisual" },
  ["\22"] = { "V-BLOCK", "PGModeVisual" },
  c = { "COMMAND", "PGModeCommand" },
  R = { "REPLACE", "PGModeReplace" },
  t = { "TERMINAL", "PGModeInsert" },
}

local function mode_segment()
  local key = vim.api.nvim_get_mode().mode:sub(1, 1) -- "niI" -> "n"

  local mode = modes[key] or { key, "PGModeNormal" }

  local name, group = mode[1], mode[2] -- Lua lists start at 1

  return "%#" .. group .. "# " .. name .. " "  .. "%*"
end


local function diagnostics_segment()
  -- { [1] = 2, [2] = 5 } means 2 errors and 5 warnings in this buffer.
  local counts = vim.diagnostic.count(0)
  local severities = {
    { vim.diagnostic.severity.ERROR, "E", "DiagnosticError" },
    { vim.diagnostic.severity.WARN, "W", "DiagnosticWarn" },
    { vim.diagnostic.severity.INFO, "I", "DiagnosticInfo" },
    { vim.diagnostic.severity.HINT, "H", "DiagnosticHint" },
  }

  local parts = {}
  for _, s in ipairs(severities) do
    local severity, label, group = s[1], s[2], s[3]
    local n = counts[severity] -- nil when there are none of this severity

    if n ~= nil and n > 0 then
      table.insert(parts, "%#" ..group .. "#" .. label .. ":" .. tostring(n) .. "%*")
    end 
  end

  -- table.concat joins a list of strings with a separator.
  return table.concat(parts, " ")
end

-- Called by Neovim on every redraw (see setup). Must return a string.
function M.render()
  return table.concat({
    mode_segment(),
    " %f %m%r", -- file path + flags
    "%=", -- everything after this is right-aligned
    diagnostics_segment(),
    "  %l:%c ", -- line:column
  })
end

-- Mode colors borrow foregrounds from groups every colorscheme defines, so
-- this works with any theme. :colorscheme wipes highlight groups, which is
-- why this re-runs on the ColorScheme event.
local function set_highlights()
  local function hl(name, link)
    vim.api.nvim_set_hl(0, name, { link = link })
  end
  hl("PGModeNormal", "Function")
  hl("PGModeInsert", "String")
  hl("PGModeVisual", "Statement")
  hl("PGModeCommand", "Constant")
  hl("PGModeReplace", "DiagnosticError")
end

function M.setup()
  set_highlights()

  -- v:lua lets a Vim expression call Lua. This string is evaluated per redraw.
  vim.o.statusline = "%!v:lua.require'proving_grounds.statusline'.render()"

  local group = vim.api.nvim_create_augroup("proving_grounds_statusline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = set_highlights })
  -- Redraw promptly when the mode or the diagnostics change.
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, {
    group = group,
    command = "redrawstatus",
  })
end

return M
