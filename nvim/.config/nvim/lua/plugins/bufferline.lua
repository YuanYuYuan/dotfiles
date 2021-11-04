require'bufferline'.setup{
  options = {
    diagnostics = "nvim_lsp",
    -- separator_style = "slant"
  }
}

vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "L", ":BufferLineMoveNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "H", ":BufferLineMovePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>1", "<Cmd>BufferLineGoToBuffer 1<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>2", "<Cmd>BufferLineGoToBuffer 2<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>3", "<Cmd>BufferLineGoToBuffer 3<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>4", "<Cmd>BufferLineGoToBuffer 4<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>5", "<Cmd>BufferLineGoToBuffer 5<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>6", "<Cmd>BufferLineGoToBuffer 6<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>7", "<Cmd>BufferLineGoToBuffer 7<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>8", "<Cmd>BufferLineGoToBuffer 8<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Space>9", "<Cmd>BufferLineGoToBuffer 9<CR>", {silent = true})
