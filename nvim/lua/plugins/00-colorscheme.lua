-- Colorscheme: material.nvim, "darker" style.
--
-- The 00- prefix makes the loader run this first, so every plugin loaded
-- after it sees the final highlight groups.
--
-- vim.pack installs plugins to:  <data>/site/pack/core/opt/<name>
-- (`:echo stdpath("data")` shows where <data> is). Once installed, the palette
-- lives in  material.nvim/lua/material/colors/init.lua  and the full docs in
-- `:help material.nvim`.

vim.pack.add({"https://github.com/marko-cerovac/material.nvim.git"})
-- must be set before require("material")

vim.g.material_style = "darker"

require("material").setup({
  styles = {
    comments = { italic = true },
  },

  -- material ships highlight groups for many plugins, but only for the ones
  -- listed here. Add names as we install them (Phase 2: "which-key", ...).
  plugins = {},
})

vim.cmd.colorscheme("material")
