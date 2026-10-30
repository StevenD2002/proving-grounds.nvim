vim.pack.add({"https://github.com/folke/which-key.nvim"})

require("which-key").setup({
  spec = {
    { "<leader>f", group = "find" },
  },
})
