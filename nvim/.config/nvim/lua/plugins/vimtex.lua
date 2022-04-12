vim.cmd [[
  " viewer
  let g:vimtex_view_method = 'zathura'
  let g:vimtex_compiler_progname = 'nvr'

  let maplocalleader = ";"

  " avoid plaintex
  let g:tex_flavor='latex'

  " enable folding
  " let g:vimtex_fold_manual=0
  let g:vimtex_fold_enabled=1

  let g:vimtex_quickfix_enabled = 0

  " fix bug of mathznoe, ref: https://github.com/lervag/vimtex/issues/2346
  autocmd BufNewFile,BufRead *.tex so $VIMRUNTIME/syntax/tex.vim

  autocmd BufWinLeave *.tex silent! VimtexClean
]]
