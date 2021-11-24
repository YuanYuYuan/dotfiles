local map = vim.api.nvim_set_keymap
local M = {}

function M.yank_and_display_path()
  local file_path = vim.fn.expand('%:p')
  vim.api.nvim_command("call setreg('+', '" .. file_path.. "')")
  print(file_path)
end

map('n', '<Space><Space>t', '<Cmd>!alacritty --working-directory %:p:h&<CR>', {noremap = true, silent=true})
map('n', '<Space><Space>l', '<Cmd>LspStart<CR>', {noremap = true})
map('n', '<C-g>', "<Cmd>lua require('keymappings').yank_and_display_path()<CR>", {noremap = true, silent=true})

return M
