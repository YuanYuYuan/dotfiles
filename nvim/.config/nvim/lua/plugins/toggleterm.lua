require('toggleterm').setup{
  open_mapping = [[<c-\>]],
  -- direction = 'vertical',
  direction = 'horizontal',
  float_opts = {
    border = 'curved',
  },
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
}

vim.keymap.set({'t'}, '<Esc>', '<C-\\><C-n>')
