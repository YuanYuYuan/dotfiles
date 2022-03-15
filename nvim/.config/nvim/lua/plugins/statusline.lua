-- Color for highlights
local colors = {
  yellow = '#f9e79f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#76d7c4',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec7063'
}

require'lualine'.setup {
  options = {
    icons_enabled = true,
    -- theme = 'nightfox',
    -- theme = 'material',
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'filetype',
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 0,
      },
      {
        'diagnostics',
        sources={'nvim_diagnostic'},
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' '
        },
      },
      -- function() return require"lsp-status".status() end,
      {
        'lsp_progress',
        display_components = {
          'lsp_client_name',
          'spinner',
          {
            'title',
            'percentage',
            'message'
          }
        },
        colors = {
          lsp_client_name = colors.yellow,
          spinner = colors.blue,
          title  = colors.red,
          percentage  = colors.red,
          message  = colors.red,
          use = true,
        },
        separators = {
          component = ' ',
          progress = ' | ',
          percentage = { pre = '', post = '%% ' },
          title = { pre = '', post = ': ' },
          lsp_client_name = { pre = '[', post = ']' },
          spinner = { pre = '', post = '' },
          message = {
            commenced = 'In Progress',
            completed = 'Completed',
            pre = '(', post = ')'
          },
        },
        timer = {
          progress_enddelay = 500,
          spinner = 500,
          lsp_client_name_enddelay = 500
        },
        spinner_symbols = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'},
      }
    },
    lualine_x = {
      'location',
      'progress',
    },
    lualine_y = {
      {
        'diff',
        symbols = {
          added = ' ',
          modified = '柳',
          removed = ' '
        }
      }
    },
    lualine_z = {
      'branch',
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
}
