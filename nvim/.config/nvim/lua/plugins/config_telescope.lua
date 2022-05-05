require('telescope').setup{
  defaults = {
    path_display = { 'smart'},
    mappings = {
      i = {
        ['<C-j>']   = 'move_selection_next',
        ['<Tab>']   = 'move_selection_next',
        ['<C-k>']   = 'move_selection_previous',
        ['<S-Tab>'] = 'move_selection_previous',
      }
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}

vim.cmd [[
  nnoremap <Space>f         <cmd> lua require('telescope.builtin').oldfiles()<cr>
  nnoremap <Space>ff        <cmd> lua require('telescope.builtin').find_files()<cr>
  nnoremap <Space>fg        <cmd> lua require('telescope.builtin').git_files()<cr>
  nnoremap <Space>fb        <cmd> lua require('telescope.builtin').buffers()<cr>
  nnoremap <Space>fh        <cmd> lua require('telescope.builtin').help_tags()<cr>
  nnoremap <Space><Space>a <cmd> lua require('telescope.builtin').lsp_code_actions()<cr>
]]

-- local builtin = require('telescope.builtin')
-- bindings = {
--   ['<Space>f'] = function() builtin.oldfiles() end,
-- }

-- telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/592
local my_livegrep = function(opts)
  opts = opts or {}
  opts.path_display = {'absolute'}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require'telescope.builtin'.live_grep(opts)
end
vim.keymap.set('n', '?', my_livegrep)
