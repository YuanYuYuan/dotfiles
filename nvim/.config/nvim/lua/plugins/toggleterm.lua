require('toggleterm').setup{
  open_mapping = [[<c-\>]],
  -- direction = 'vertical',
  direction = 'horizontal',
  float_opts = {
    border = 'curved',
  },
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
}

vim.keymap.set({'t'}, '<Esc>', '<C-\\><C-n>')

local speak_and_trans = function(text)
  local prev_win = vim.api.nvim_get_current_win()
  local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
  require('toggleterm').exec(string.format('trans -b -speak -t zh-TW "%s"', text))
  vim.api.nvim_win_set_cursor(prev_win, prev_pos)
  vim.api.nvim_set_current_win(prev_win)
end

-- speak & translate selection
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'text',
  callback = function()
    vim.keymap.set({'v'}, '<F3>', function() speak_and_trans(require('utils').get_visual_selection()) end)
    vim.keymap.set({'n'}, '<F3>', function() speak_and_trans(vim.api.nvim_get_current_line()) end)
    vim.keymap.set({'v'}, '<Space>3', function() speak_and_trans(require('utils').get_visual_selection()) end)
    vim.keymap.set({'n'}, '<Space>3', function() speak_and_trans(vim.api.nvim_get_current_line()) end)
  end,
})

-- python send visual selection
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'python',
  callback = function()
    vim.keymap.set({'v'}, '<F3>', ':ToggleTermSendVisualSelection<CR>')
    vim.keymap.set({'v'}, '<Space>3', ':ToggleTermSendVisualSelection<CR>')
  end,
})
