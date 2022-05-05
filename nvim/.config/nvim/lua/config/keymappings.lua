local map = vim.api.nvim_set_keymap
local M = {}

local yank_and_display_path = function()
  local file_path = vim.fn.expand('%:p')
  vim.api.nvim_command("call setreg('+', '" .. file_path.. "')")
  print(file_path)
end

local switch_brackets = function()
  vim.cmd('noau normal! "vy"')
  vim.cmd[[
    '<,'>s/\[/{/g
    '<,'>s/\]/}/g
  ]]
  -- local _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
  -- local _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))
  -- if ecol > 999 then
  --   ecol = 999
  -- end
  -- local x = vim.fn.getreg('v'):gsub('%[', '{'):gsub('%]', '}')
  -- local lines = {}
  -- for l in x:gmatch('[^\r\n]+') do
  --   table.insert(lines, l)
  -- end
  -- print(vim.inspect(x))
  -- print(vim.inspect(lines))
  -- print('vim:', vim.inspect(vim.split(x, '\n', true)))
  -- print('bufline count: ', vim.api.nvim_buf_line_count(0))
  -- print(srow, scol, erow, ecol)
  -- vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, vim.split(x, '\n', true))
  -- -- print(vim.fn.getreg('v'))
end

vim.keymap.set(
  {'i', 'n'},
  '<F8>',
  '<Cmd>silent !alacritty --working-directory %:p:h&<CR>',
  { noremap = true }
)

vim.cmd [[
    " Auto search and clean trailing space after file written.
    autocmd BufWritePre * %s/\s\+$//e

    " And replace tab automatically
    autocmd BufWritePre * retab

    " save and (force) exit
    autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | bdelete | endif

    function! QuitOrBufferDelete()
        let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
        let empty_name = (expand('%') == '')
        if (buf_len && empty_name)
            exec 'q'
        else
            exec 'bd!'
        endif
    endfunction
]]


local key_mappings = {
  basics = {
    -- view in middle while editing
    ['zz'] = {i = '<C-o>zz'},

    ['aa'] = {i = '<C-o>a'},

    -- select last pasted
    ['gp'] = '`[v`]',

    -- macros
    ['T'] = 'qt',
    ['t'] = '@t',

    -- jump between changes and then view it in middle
    ['g;'] = 'g;zz',
    ['g,'] = 'g,zz',

    ['vv'] = '<C-v>',

    ['<C-g>'] = yank_and_display_path,
    ['gs'] = {v = switch_brackets},
  },

  buffer ={
    ['Q'] = '<Cmd>q<CR>',
    ['!'] = '<Cmd>q!<CR>',
    ['X'] = '<Cmd>x<CR>',
    ['<Space>w'] = '<Cmd>w<CR>',
    ['<Space>x'] = '<Cmd>x<CR>',
  },

  search = {
    ['n'] = {n = 'nzv', v = '"ny/<C-r>n<CR>zv'},
    ['N'] = {n = 'Nzv', v = '"ny/<C-r>n<CR>NNzv'},
    ['C'] = {v = '"ny/<C-r>n<CR>Ncgn'},
    ['S'] = {v = ':s///gc<Left><Left><Left><Left>'},
  },

  page_scrolling = {
    ['<C-k>'] = {n = '<C-u>', v = '5k'},
    ['<C-j>'] = {n = '<C-d>', v = '5j'},
  },

  command_mode = {
    -- NOTE: silent map would cause mapping failed
    -- https://github.com/vim/vim/issues/6832
    ['<A-b>'] = {c = '<S-Left>'},
    ['<A-f>'] = {c = '<S-Right>'},
    ['<C-a>'] = {c = '<Home>'},
  },

  line_dragging = {
    -- vertical
    ['<C-u>'] = {
      n = '<Cmd>move .-2<CR>',
      v = '<Cmd>move \'<-2<CR>gv=gv',
      -- i = '<Cmd>move .-2<CR>gi',
    },
    ['<C-d>'] = {
      n = '<Cmd>move .+1<CR>',
      v = '<Cmd>move \'>+1<CR>gv=gv',
      -- i = '<Cmd>move .+1<CR>gi',
    },

    -- horizontal
    ['>'] = {n = '>>', v = '>gv'},
    ['<'] = {n = '<<', v = '<gv'},
  },
}

for _, mapping in pairs(key_mappings) do
  for key, binding in pairs(mapping) do
    if type(binding) == 'table' then
      for mode, mode_binding in pairs(binding) do
        vim.keymap.set(mode, key, mode_binding)
      end
    else
      vim.keymap.set('n', key, binding)
    end
  end
end

-- map('n', '<Space><Space>l', '<Cmd>LspStart<CR>', {noremap = true})
-- map('n', '<Space><Space>n', '<Cmd>nohlsearch<CR>', {noremap = true})
-- map('v', '<Space><Space>n', '<Cmd>nohlsearch<CR>', {noremap = true})
