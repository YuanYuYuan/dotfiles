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

local cmd_list = {
  makrdown = function()
    vim.api.nvim_command('MarkdownPreview')
  end,
  lua = function()
    vim.api.nvim_command('luafile %')
    print('Executed lua file.')
  end
}

local f3_group = augroup('F3AuGroup')
for filetype, cmd in pairs(cmd_list) do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetype,
    group = f3_group,
    callback = function()
      vim.keymap.set(
        {'i', 'n'},
        '<F3>',
        cmd,
        {
          noremap = true,
          silent = false
        }
      )
    end
  })
end

