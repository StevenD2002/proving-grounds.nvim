-- Plugin loader.
--
-- Neovim 0.12 ships its own plugin manager, vim.pack, so there is nothing to
-- bootstrap (no lazy.nvim git clone dance).  :help vim.pack
--
-- Convention: ONE FILE PER PLUGIN in lua/plugins/. Each file:
--   1. calls vim.pack.add({ "https://github.com/owner/repo" })  -- installs + loads
--   2. configures the plugin (require("x").setup({...}), keymaps, ...)
--
-- This loader requires those files in alphabetical order. If something must
-- load first (the colorscheme, usually), prefix its filename: 00-colorscheme.lua.
-- Explicit ordering beats clever dependency graphs.
--
-- vim.pack records exact plugin versions in nvim/nvim-pack-lock.json. That file
-- is committed: it's what makes this config reproducible on another machine.
-- Useful commands:
--   :lua vim.pack.update()       -- fetch updates, review them, then :write
--   :lua vim.pack.get()          -- what's installed

local plugin_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")

local modules = {}
for name, kind in vim.fs.dir(plugin_dir) do
  local module = name:match("^(.+)%.lua$")
  if kind == "file" and module then
    table.insert(modules, module)
  end
end
table.sort(modules) -- vim.fs.dir doesn't promise any order; we do

for _, module in ipairs(modules) do
  require("plugins." .. module)
end
