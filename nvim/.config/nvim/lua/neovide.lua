local map = vim.api.nvim_set_keymap

-- font size & font list
local font_size = 9
local font_list = {
  'FiraCode Nerd Font',
  'Font Awesome 5 Free',
  'DejaVuSans',
  'Noto Color Emoji',
}

-- setup font list
local fonts = ''
for _, str in ipairs(font_list) do
  if fonts == '' then
    fonts = str
  else
    fonts = fonts .. ',' .. str
  end
end

local function set_font(fsize)
  vim.opt.guifont = fonts .. ':h'..  tostring(fsize)
end

local M = {}
function M.change_size(change)
  font_size = font_size + change
  vim.opt.guifont = fonts .. ':h'..  tostring(font_size)
end

set_font(font_size)
map('n', '<C-=>', "<cmd>lua require('neovide').change_size(1)<CR>", {noremap = true})
map('n', '<C-->', "<cmd>lua require('neovide').change_size(-1)<CR>", {noremap = true})
map('n', '<C-->', "<cmd>lua require('neovide').change_size(-1)<CR>", {noremap = true})
map('c', '<C-v>', '<C-r>+', {noremap = true})

return M
