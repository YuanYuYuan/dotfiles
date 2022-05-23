require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'comment',
    'c',
    'cpp',
    'lua',
    'rust',
    'javascript',
    'html',
    'json',
    'json5',
    'haskell',
    'python',
  },
  highlight = {
    enable = true,
  },
}