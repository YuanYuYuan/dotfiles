local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'packer', 'vista', 'dbui'}

local colors = {
  bg = '#282c34',
  crayola_yellow = '#fce883',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left = {
  { ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        v = 'VISUAL',
        V = 'VISUAL LINE',
        [''] = 'VISUAL BLOCK',
        s = 'SELECT',
        S = 'SELECT',
        r = 'REPLACE',
        R = 'REPLACE',
      }
      return '  ' .. alias[vim.fn.mode()]
    end,
    separator = ' ',
    separator_highlight = {colors.purple,function()
      if not buffer_not_empty() then
        return colors.purple
      end
      return colors.darkblue
    end},
    highlight = {colors.darkblue,colors.purple,'bold'},
  }},
  { FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.darkblue
    },
  }},
  { FileFormat = {
    provider = {
      function () return vim.bo.filetype .. " " end,
      'LineColumn'
    },
    condition = buffer_not_empty,
    separator = ' ',
    highlight = {colors.magenta,colors.darkblue},
    separator_highlight = {colors.bg,colors.darkblue},
  }},
  -- { FileName = {
  --   provider = {'FileName', 'LineColumn'},
  --   condition = buffer_not_empty,
  --   separator = ' ',
  --   highlight = {colors.magenta,colors.darkblue},
  --   separator_highlight = {colors.bg,colors.darkblue},
  -- }},
  -- { FilePath = {
  --   provider = function() return vim.fn.expand("%") end,
  --   -- provider = function() return vim.fn.pathshorten(vim.fn.getcwd()) end,
  --   condition = buffer_not_empty,
  --   separator = ' ',
  --   highlight = {colors.magenta,colors.darkblue},
  --   separator_highlight = {colors.bg,colors.darkblue},
  -- }},
  -- { LeftEnd = {
  --   provider = function() return '' end,
  --   separator = ' ',
  --   separator_highlight = {colors.purple,colors.bg},
  --   -- highlight = {colors.purple,colors.purple}
  -- }},
  { DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }},
  { DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }},
  { LspStatus = {
    provider = function() return require('lsp-status').status() end,
    highlight = {colors.crayola_yellow,colors.bg, 'bold'},
  }},
}
gls.right = {
  { GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.orange,colors.purple},
    separator = '',
    separator_highlight = {colors.bg,colors.purple},
  }},
  { GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.grey,colors.purple},
  }},
  { DiffAdd = {
      provider = 'DiffAdd',
      condition = checkwidth,
      icon = ' ',
      highlight = {colors.green,colors.purple},
  }},
  { DiffModified = {
    provider = 'DiffModified',
    -- condition = checkwidth,
    condition = condition.check_git_workspace,
    icon = ' ',
    highlight = {colors.orange,colors.purple},
  }},
  { DiffRemove = {
    provider = 'DiffRemove',
    -- condition = checkwidth,
    condition = condition.check_git_workspace,
    icon = ' ',
    highlight = {colors.red,colors.purple},
  }},
  { PerCent = {
    provider = {'LinePercent'},
    separator = ' ' ,
    separator_highlight = {colors.darkblue, colors.purple},
    highlight = {colors.grey, colors.darkblue},
  }},
}
gls.short_line_left = {
  { BufferType = {
    provider = 'FileTypeName',
    separator = '  ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }},
}
gls.short_line_right = {
  { BufferIcon = {
    provider = 'BufferIcon',
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }},
}

return gls
