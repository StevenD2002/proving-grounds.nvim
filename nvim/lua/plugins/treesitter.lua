vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})

require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
"rust", "javascript", "typescript", "go", "python", "json", "yaml", "toml", "gomod", "gitcommit", "bash", "dockerfile", "tsx"
})

local group = vim.api.nvim_create_augroup("proving_grounds_treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", { group = group, callback = function() pcall(vim.treesitter.start) end })
