local utils = require('utils')

local augroup = function(group_name)
  return vim.api.nvim_create_augroup(group_name, {clear = true})
end

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {
    'haskell',
    'lua',
    'yaml',
    'json',
    'json5',
    'html',
    'tex'
  },
  group = vim.api.nvim_create_augroup(
    'ShorterSpaceAuGroup',
    {clear = true}
  ),
  command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2',
})


-- local term = require('toggleterm')
-- local toggle_term = function()
--   local prev_win = vim.api.nvim_get_current_win()
--   local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
--   vim.cmd('write')
--   term.exec(cmd_list[vim.bo.filetype](vim.fn.expand('%')))
--   vim.api.nvim_win_set_cursor(prev_win, prev_pos)
--   vim.api.nvim_set_current_win(prev_win)
-- end


local cmd_table = utils.Table {
  makrdown = 'MarkdownPreview',
  lua = 'luafile %',
  tex = 'VimtexCompile',
}
:map(function(cmd)
  return function()
    vim.cmd('write')
    vim.cmd(cmd)
  end
end)


local f3_group = augroup('F3AuGroup')
for ft, cmd in pairs(cmd_table) do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = ft,
    group = f3_group,
    callback = function()
      vim.keymap.set({'i', 'n'}, '<F3>', cmd)
    end
  })
end


vim.cmd[[
    " auto save and restore
    let blacklist = ['qf']
    autocmd BufWritePost,BufWinLeave *.* if index(blacklist, &ft) < 0 | mkview
    autocmd BufWinEnter *.* if index(blacklist, &ft) < 0 | silent! loadview

    " Auto search and clean trailing space after file written.
    autocmd BufWritePre * %s/\s\+$//e

    " And replace tab automatically
    autocmd BufWritePre * retab
]]
