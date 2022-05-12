require('nightfox').setup({
  options = {
    transparent = true,
    styles = {
      comments = 'italic',
      keywords = 'bold',
      types = 'bold',
    },
  },
  groups = {
    all = {
      Folded = { bg = 'none' },
      Comment = { fg = '#33cccc' },
      Visual = { bg = '#e6faff' },
    }
  }
})
-- vim.cmd('colorscheme nightfox')
vim.cmd('colorscheme nordfox')
