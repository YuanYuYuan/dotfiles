require('toggleterm').setup{
  open_mapping = [[<c-\>]],
  direction = 'vertical',
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

-- local Terminal = require('toggleterm.terminal').Terminal
local term = require('toggleterm')

local toggle_term = function()
  if vim.bo.filetype == 'cpp' then
    local prev_win = vim.api.nvim_get_current_win()
    local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
    vim.api.nvim_command('write')
    local cpp_file = vim.fn.expand('%')
    local exe_file = vim.fn.expand('%<') .. '.out'
    local cmd = string.format('g++ %s -o %s && ./%s', cpp_file, exe_file, exe_file)
    term.exec(cmd)
    vim.api.nvim_win_set_cursor(prev_win, prev_pos)
    vim.api.nvim_set_current_win(prev_win)
  else
    print('Filetype: ' .. vim.bo.filetype .. ' is not supported.')
  end
end

vim.keymap.set('n', '<space>g', toggle_term, {noremap = true, silent = false})
