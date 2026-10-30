local map = vim.keymap.set

vim.pack.add({"https://github.com/folke/snacks.nvim"})


require("snacks").setup({
  notifier = {
    enabled = true,
  },
  picker = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true }
    }
  }
})

map("n", "<leader>ff", function() Snacks.picker.files() end, {desc = "Opens the file search menu"})
map("n", "<leader>gg", function() Snacks.lazygit() end, {desc = "Opens the git menu for quick git actions"})
