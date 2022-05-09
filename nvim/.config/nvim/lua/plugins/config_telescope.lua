local utils = require('utils')
local builtin = require('telescope.builtin')

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

utils.bind_mappings({
  ['<Space>f'] = builtin.oldfiles,
  ['<Space>tf'] = builtin.find_files,
  ['<Space>tg'] = builtin.git_files,
  ['<Space>th'] = builtin.help_tags,
  ['<Space>ta'] = builtin.lsp_code_actions,
  ['?'] = my_livegrep,
})
