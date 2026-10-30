local map = vim.keymap.set

vim.pack.add({"https://github.com/folke/snacks.nvim"})


require("snacks").setup({
  notifier = {
    enabled = true,
  },
  picker = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true } -- Wrap notifications
    }
  }
})

map("n", "<leader>ff", function() Snacks.picker.files() end, {desc = "Opens the file search menu"})
