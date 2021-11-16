local map = vim.api.nvim_set_keymap

map('n', '<Space>rt', '<Cmd>!alacritty --working-directory %:p:h&<CR>', {noremap = true, silent=true})
map('n', '<Space>rl', '<Cmd>LspStart<CR>', {noremap = true})
