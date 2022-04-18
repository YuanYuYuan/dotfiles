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


local cmd_list = {
  c = function(file)
    local exe = file:gsub('.c', '.out')
    return string.format('gcc %s -o %s && ./%s', file, exe, exe)
  end,
  cpp = function(file)
    local exe = file:gsub('.cpp', '.out')
    return string.format('g++ %s -o %s && ./%s', file, exe, exe)
  end,
  python = function(file)
    return 'python ' .. file
  end,
  bash = function(file)
    return 'bash ' .. file
  end,
}

local supported_filetypes = {}
for k, _ in pairs(cmd_list) do
  supported_filetypes[#supported_filetypes + 1] = k
end

local term = require('toggleterm')
local toggle_term = function()
  local prev_win = vim.api.nvim_get_current_win()
  local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
  vim.api.nvim_command('write')
  term.exec(cmd_list[vim.bo.filetype](vim.fn.expand('%')))
  vim.api.nvim_win_set_cursor(prev_win, prev_pos)
  vim.api.nvim_set_current_win(prev_win)
end

local bind_toggle_term = function ()
  vim.keymap.set(
    {'i', 'n'},
    '<F3>',
    toggle_term,
    {noremap = true, silent = false}
  )
end

local au_group = vim.api.nvim_create_augroup('ToggleTermAuGroup', {clear = true})
vim.api.nvim_create_autocmd('Filetype', {
  pattern = supported_filetypes,
  group = au_group,
  callback = bind_toggle_term,
})

