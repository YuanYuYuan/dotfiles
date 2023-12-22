local utils = require("utils")

local yank_and_display_path = function()
  local file_path = vim.fn.expand("%:p")
  vim.cmd("call setreg('+', '" .. file_path .. "')")
  print(file_path)
end

local switch_brackets = function()
  vim.cmd('noau normal! "vy"')
  vim.cmd([[
    '<,'>s/\[/{/g
    '<,'>s/\]/}/g
  ]])
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

-- Ref: https://github.com/chrishrb/gx.nvim
local open_in_neovide = function()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))

  local line = vim.api.nvim_get_current_line()

  local left = 1
  for i = 1, col-1 do
    local j = col - i + 1
    local c = string.sub(line, j, j)
    if string.match(c, "%s") ~= nil then
      left = j + 1
      break
    end
  end

  local right = string.len(line)
  for i = col+1, string.len(line) do
    local c = string.sub(line, i, i)
    if string.match(c, "%s") ~= nil then
      right = i - 1
      break
    end
  end

  local args = {vim.fn.stdpath("config") .. "/scripts/open-in-neovide.sh"}
  for w in string.sub(line, left, right):gmatch("([^:]+)") do
    table.insert(args, w)
  end

  vim.fn.system({unpack(args)})
end


vim.keymap.set({ "i", "n" }, "<F8>", "<Cmd>silent !alacritty --working-directory %:p:h&<CR>")

-- TODO: rewrite it in lua
vim.cmd([[
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

    nnoremap <Space>q :call QuitOrBufferDelete()<CR>
]])

local write_and_format = function()
  vim.cmd([[
    " remove trailing whitespaces
    %s/\s\+$//e

    " convert spaces to tab
    retab

    " remove trailing lines
    silent! %s#\($\n\s*\)\+\%$##

    " write the buffer
    w
  ]])
end

utils.bind_mapping_collection({
  basics = {
    -- view in middle while editing
    ["zz"] = { i = "<C-o>zz" },

    -- select last pasted
    ["gp"] = "`[v`]",

    ["va'"] = "v2i'",
    ['va"'] = 'v2i"',

    -- macros
    ["T"] = "qt",
    ["t"] = "@t",

    -- jump between changes and then view it in middle
    ["g;"] = "g;zz",
    ["g,"] = "g,zz",

    -- jump forward
    ["<C-m>"] = "<C-i>",

    ["vv"] = "<C-v>",

    ["gs"] = { v = switch_brackets },

    -- paste last yank
    ["<Space>p"] = { ["n,v"] = '"0p' },

    -- undo/redo
    ["U"] = "<C-r>",
    ["uu"] = { i = "<Esc>u" },

    -- window
    ["qw"] = "<C-w>",
  },

  clipboard = {
    ["<C-g>"] = yank_and_display_path,
    -- open the file stored in clipboard
    ["<Space>o"] = ":e <C-r>+<CR>",
  },

  movement_tricks = {
    ["aa"] = { i = "<C-o>a" },
    ["B"] = { ["n,v"] = "^" },
    ["E"] = { ["n,v"] = "g_" },

    -- movement in too long lines
    ["j"] = "gj",
    ["k"] = "gk",
  },

  window_resize = {
    ["="] = "<C-w>+",
    ["-"] = "<C-w>-",
    ["_"] = "<C-w><",
    ["+"] = "<C-w>>",
  },

  buffer = {
    ["Q"] = "<Cmd>q<CR>",
    ["!"] = "<Cmd>q!<CR>",
    ["X"] = "<Cmd>x<CR>",
    -- ['<Space>w'] = '<Cmd>w<CR>',
    ["<Space>w"] = write_and_format,
    ["<Space>x"] = "<Cmd>x<CR>",
  },

  search_and_replace = {
    ["n"] = { n = "nzv", v = '"ny/<C-r>n<CR>zv' },
    ["N"] = { n = "Nzv", v = '"ny/<C-r>n<CR>NNzv' },
    ["C"] = { v = '"ny/<C-r>n<CR>Ncgn' },
    ["S"] = { v = ":s///gc<Left><Left><Left><Left>" },
  },

  page_scrolling = {
    ["<C-k>"] = { n = "<C-u>" },
    ["<C-j>"] = { n = "<C-d>" },
  },

  command_mode = {
    -- NOTE: silent map would cause mapping failed
    -- https://github.com/vim/vim/issues/6832
    ["<A-b>"] = { c = "<S-Left>" },
    ["<A-f>"] = { c = "<S-Right>" },
    ["<C-a>"] = { c = "<Home>" },
  },

  line_dragging = {
    -- vertical
    ["<C-u>"] = {
      n = "<Cmd>move .-2<CR>",
      v = "<Cmd>move '<-2<CR>gv=gv",
      -- i = '<Cmd>move .-2<CR>gi',
    },
    ["<C-d>"] = {
      n = "<Cmd>move .+1<CR>",
      v = "<Cmd>move '>+1<CR>gv=gv",
      -- i = '<Cmd>move .+1<CR>gi',
    },

    -- horizontal
    [">"] = { n = ">>", v = ">gv" },
    ["<"] = { n = "<<", v = "<gv" },
  },

  break_points = {
    [","] = { i = ",<C-g>u" },
    ["."] = { i = ".<C-g>u" },
    ["!"] = { i = "!<C-g>u" },
    ["?"] = { i = "?<C-g>u" },
  },

  git = {
    ["<Space>gb"] = { n = "<Cmd>Git blame<CR>" },
  },

  open_in_neovide = {
    ["gn"] = open_in_neovide,
  },

})
