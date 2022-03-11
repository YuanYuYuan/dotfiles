local map = vim.api.nvim_set_keymap
local M = {}

function M.yank_and_display_path()
  local file_path = vim.fn.expand('%:p')
  vim.api.nvim_command("call setreg('+', '" .. file_path.. "')")
  print(file_path)
end

function M.switch_brackets()
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
  -- -- vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, {'wtf', 'wtf2'})
  -- -- print(vim.fn.getreg('v'))
end


map('n', '<F8>', '<Cmd>silent !alacritty --working-directory %:p:h&<CR>', {noremap = true, silent=true})
map('i', '<F8>', '<Cmd>silent !alacritty --working-directory %:p:h&<CR>', {noremap = true, silent=true})
map('n', '<Space><Space>l', '<Cmd>LspStart<CR>', {noremap = true})
map('n', '<C-g>', "<Cmd>lua require('keymappings').yank_and_display_path()<CR>", {noremap = true, silent=true})
map('n', '<Space><Space>n', '<Cmd>nohlsearch<CR>', {noremap = true})
map('v', '<Space><Space>n', '<Cmd>nohlsearch<CR>', {noremap = true})
map('v', 'gs', "<Cmd>silent lua require('keymappings').switch_brackets()<CR>", {noremap = true, silent=true})

-- telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/592
M.my_livegrep = function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require'telescope.builtin'.live_grep(opts)
end
vim.api.nvim_set_keymap('n', '?', "<Cmd>lua require('keymappings').my_livegrep()<CR>", {noremap = true, silent=true})

return M
