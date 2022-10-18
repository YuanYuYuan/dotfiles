local utils = require('utils')
local builtin = require('telescope.builtin')

require('telescope').setup{
  defaults = {
    -- path_display = { 'smart'},
    wrap_results = true,
    mappings = {
      i = {
        ['<C-j>']   = 'move_selection_next',
        ['<Tab>']   = 'move_selection_next',
        ['<C-k>']   = 'move_selection_previous',
        ['<S-Tab>'] = 'move_selection_previous',
      }
    },
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--smart-case',
      '--column',
      '--fixed-strings',   -- disable regex
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer',
        }
      }
    }
  },
}


-- https://github.com/nvim-telescope/telescope.nvim/issues/592
local my_live_grep = function(opts)
  opts = opts or {}
  opts.path_display = {'absolute'}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- if not git then active lsp client root
    -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
    opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
  end
  require('telescope.builtin').live_grep(opts)
end

utils.bind_mappings({
  ['<Space>f'] = builtin.oldfiles,
  ['<Space><Space>f'] = builtin.find_files,
  ['<Space><Space>g'] = builtin.git_files,
  ['<Space><Space>h'] = builtin.help_tags,
  ['<Space><Space>c'] = vim.lsp.buf.code_action,
  ['<Space><Space>b'] = builtin.buffers,
  ['<Space><Space>q'] = require('telescope').extensions.frecency.frecency,
  ['?'] = {
    v = function()
      my_live_grep({default_text = utils.get_visual_selection()})
    end,
    n = my_live_grep
  },
})


local command_mode_extension = function()
  local mode = vim.fn.getcmdtype()
  if mode == ':' then
    require('telescope.builtin').command_history()
  elseif mode == '/' then
    require('telescope.builtin').search_history()
  else
    return '<C-f>'
  end
end

vim.keymap.set({'c'}, '<C-f>', command_mode_extension)
