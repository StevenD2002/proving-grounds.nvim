-- Home-grown features live here, one module per feature.
--
-- Each feature module exports setup(). To switch an experiment off, set it to
-- false below: it stops loading but the code stays in the repo for later.
-- This is a list (not a map) so features load in a predictable order.

local M = {}

M.features = {
  { "cheatsheet", true }, -- <leader>? opens CHEATSHEET.md in a float
  {"statusline", true},
}

function M.setup()
  for _, feature in ipairs(M.features) do
    local name, enabled = feature[1], feature[2]
    if enabled then
      require("proving_grounds." .. name).setup()
    end
  end
end

return M
