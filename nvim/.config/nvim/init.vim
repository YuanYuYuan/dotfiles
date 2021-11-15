" { Generics } {{{

    " FIXME: this seems conflict with treesitter
    " and block the autostart of LSP
    " syntax enable                         " syntax highlight
    syntax on                         " syntax highlight
    syntax sync fromstart
    set showcmd                       " Show partial commands in the last line of the screen
    set history=10000                 " history limit
    set cursorline                    " highlight current line
    set autochdir                     " auto chanage the working directory
    set encoding=utf-8                " UTF-8 encodinf
    set diffopt+=iwhite               " ignore whitespace in vimdiff
    set mouse=a                       " enable mouse
    set hidden                        " hides buffers instead of closing them
    set timeout timeoutlen=400        " set timeout to use double key in imap confortablely
    set number relativenumber         " line number
    set backspace=indent,eol,start    " normal delete
    set showmatch                     " highlight matching brackets
    set wildmenu                      " show menu for the command completion
    set previewheight=5               " hight of completion preview
    set pumheight=10                  " height of pop-up menu
    " set virtualedit=block
    set updatetime=300
    set signcolumn=yes

    let mapleader = "\<Space>"

    " { Clipboard } {{{
        " use system's clipboard
        set clipboard=unnamedplus

        " paste last buffer
        vnoremap <Space>p "0p
        nnoremap <Space>p "0p
    " }}}

    " { Ignoring case } {{{
        set ignorecase  " ignore case during search
        set smartcase   " ignore case if search pattern is all lowercase
        set wildignorecase " ignore case when doing completion
    " }}}

    " { Lazyredraw } {{{
        " TODO: Improve implementation
        " redraw only in need
        set nolazyredraw
        " autocmd InsertLeave * set lazyredraw
        " autocmd InsertEnter * set nolazyredraw

        function! ToggleLazyRedraw()
            exec 'set lazyredraw!'
            if &lazyredraw == 0
                echo 'LazyRedraw off'
            else
                echo 'LazyRedraw on'
            endif
        endfunction
        nnoremap <Space>cr :call ToggleLazyRedraw()<CR>
    " }}}

    " { Tab/spaces } {{{
        set expandtab              " expand tab to spaces
        set smarttab               " use shiftwidth instead of tabstop at start of lines
        set tabstop=4              " set tab to 4-spaces-wide
        set softtabstop=4          " set tab to 4-spaces-wide when editing
        set shiftwidth=4           " < and > will shift 4 spaces

    " }}}

    " { Indention } {{{
        set autoindent
        set smartindent
    " }}}

    " { too long lines } {{{
        " wrap each too long line into multiple rows)
        set wrap

        " movement in too long lines
        nnoremap j gj
        nnoremap k gk
    " }}}

    " { Terminal } {{{
        " exit key mappings
        tnoremap <Esc> <C-\><C-n>
        " Deprecated
        " tnoremap qq <C-\><C-n>
        " tnoremap q<Tab> <C-\><C-n><C-w><C-p>

        " clean settings in terminal
        autocmd TermOpen * set nonumber norelativenumber signcolumn=no
        autocmd TermOpen * startinsert
        autocmd BufWinEnter,WinEnter term://* startinsert

        " auto close after exited
        autocmd TermClose * call nvim_input("<CR>")

        " function to toggle terminal
        let g:term_buf = 0
        let g:term_win = 0
        function! ToggleTerminal(height)
            if win_gotoid(g:term_win)
                hide
            else
                if bufexists(g:term_buf) && g:term_buf != 0
                    exec "split | buffer " . g:term_buf
                else
                    exec "split | terminal"
                    let g:term_buf = bufnr("")
                endif
                let g:term_win = win_getid()
                exec "resize " . a:height
            endif
        endfunction

        " press <F7> to toggle terminal
        nnoremap <silent> <F7> :call ToggleTerminal(12)<CR>
        inoremap <silent> <F7> <Esc>:call ToggleTerminal(12)<CR>
        tnoremap <silent> <F7> <C-\><C-n>:call ToggleTerminal(12)<CR>
    " }}}
    " { Completion } {{{
        " The tab trigger is done by SuperTab.
        " And the intelligent completion relies on coc.vim.
        " But note that the completion in Julia is handled by julia-vim

        " Press <Enter> to select the completion
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " }}}

" }}}

" { Filetype plugins } {{{
    " enable filtype setting
    filetype plugin indent on

    " edit filetype plugin
    nnoremap <silent> <F5> :exec 'edit $HOME/.config/nvim/ftplugin/' .  &ft . '.vim' <CR>

    " markdown
    autocmd FileType markdown inoremap <buffer> <silent> <F3> <Esc>:MarkdownPreview<CR>
    autocmd FileType markdown nnoremap <buffer> <silent> <F3> :MarkdownPreview<CR>

    " json5
    autocmd FileType json5 inoremap <buffer> <silent> <F3> <Esc>:!json5 -v %<CR>
    autocmd FileType json5 nnoremap <buffer> <silent> <F3> :!json5 -v %<CR>

    " c
    function! RunC()
        exec "w"
        exec "!gcc % -o %< && ./%<"
    endfunction
    autocmd FileType c inoremap <buffer> <silent> <F3> <Esc>:call RunC()<CR>
    autocmd FileType c nnoremap <buffer> <silent> <F3> :call RunC()<CR>

    " cpp
    function! RunCPP()
        exec "w"
        exec "!g++ % -o %<.out && ./%<.out"
    endfunction
    autocmd FileType cpp inoremap <buffer> <silent> <F3> <Esc>:call RunCPP()<CR>
    autocmd FileType cpp nnoremap <buffer> <silent> <F3> :call RunCPP()<CR>

    " python
    function! RunPython()
        exec "w"
        exec "!python %"
    endfunction
    autocmd FileType python inoremap <buffer> <silent> <F3> <Esc>:call RunPython()<CR>
    autocmd FileType python nnoremap <buffer> <silent> <F3> :call RunPython()<CR>

    " bash
    function! RunBash()
        exec "w"
        exec "!bash %"
    endfunction
    autocmd FileType sh,bash inoremap <buffer> <silent> <F3> <Esc>:call RunBash()<CR>
    autocmd FileType sh,bash nnoremap <buffer> <silent> <F3> :call RunBash()<CR>

    " asciidoc
    function! RunAsciidoc()
        exec "w"
        exec "AsyncRun $HOME/Workings/scripts/asciidoc-autoreload.sh %"
    endfunction
    autocmd FileType asciidoc inoremap <buffer> <silent> <F3> <Esc>:call RunAsciidoc()<CR>
    autocmd FileType asciidoc nnoremap <buffer> <silent> <F3> :call RunAsciidoc()<CR>

    " julia
    autocmd BufRead,BufNewFile *.jl :set filetype=julia

    " less space
    autocmd FileType haskell,lua,yaml,json,json5,html,tex setlocal tabstop=2 softtabstop=2 shiftwidth=2

" }}}

" { Lua Plugins } {{{
lua require('plugins')
" }}}

" { Search configuration } {{{
    set hlsearch            " highlight search
    set incsearch           " incremental search
    set inccommand=nosplit  " live substitution

    " next/previous search
    vnoremap 0 n
    vnoremap 9 N
    vnoremap n "ny/<C-r>n<CR>zzzv
    vnoremap N "ny/<C-r>n<CR>NNzzzv
    vnoremap C "ny/<C-r>n<CR>Ncgn

    nnoremap n nzzzv
    nnoremap N Nzzzv

    " grep search and show on quickfix
    vnoremap <C-f> y:vimgrep <C-r>" %<CR> \| :copen <CR>
    nnoremap <C-f> :vimgrep <C-r>/ %<CR> \| :copen <CR>

    " search/substitute
    vnoremap S :s///gc<Left><Left><Left><Left>
" }}}

" { Color } {{{
    set synmaxcol=150          " limit max columns of highlight to prevent slowing down

    set background=dark
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    set t_Co=256

    colorscheme zephyr

    " autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    " autocmd vimenter * hi LineNr guibg=NONE ctermbg=NONE
    " autocmd vimenter * hi Folded guibg=NONE ctermbg=NONE
    " autocmd vimenter * hi SignColumn guibg=NONE ctermbg=NONE

    " Disable background highlight
    " highlight Folded ctermbg=None
    " highlight Folded ctermfg=74

    " autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
    " autocmd vimenter * highlight Search ctermfg=red ctermbg=none guibg=none guifg=red
    " autocmd vimenter * highlight Pmenu ctermbg=blue guibg=none

    highlight Search ctermfg=red ctermbg=none guibg=none guifg=red

    " highlight for searching text
    highlight Search ctermfg=red ctermbg=none

    " highlight for pop-up menu
    " highlight Pmenu ctermbg=blue guibg=none

    " toggle concealment
    set conceallevel=2
    " disable conceal under the cusorline
    set concealcursor=""
    nnoremap <Space>cc :setlocal conceallevel=<c-r>=&conceallevel == 0 ? '2' : '0'<cr><cr>

    " toggle highlight search
    nnoremap <Space>ch :set hlsearch! hlsearch?<CR>
" }}}

" { Lua settings } {{{
lua <<EOF
if vim.fn.exists('g:neovide') > 0 then
    require('neovide')
end
EOF
" }}}


" { Folding } {{{
    set foldenable

    " default foldmethod
    setlocal foldmethod=syntax
    " setlocal foldmethod=expr

    " " FIXME: adress the treesitter folding issuse
    " autocmd BufWritePost * lua vim.opt.foldmethod = vim.opt.foldmethod

    " " FIXME
    " set foldexpr=nvim_treesitter#foldexpr()

    set fillchars=fold:\ " use trailing space as the padding of folding
    set foldtext=MyFoldText()
    function! MyFoldText()
        let head = getline(v:foldstart)
        let head = substitute(head, '{{{', '', 'g')
        let head = substitute(head, '\s\+$', '', 'g')
        let tail = substitute(trim(getline(v:foldend)), '.*}}}', '', 'g')
        return head . ' ... ' . tail
    endfunction

    " Open the folding automatically in conditions of
    "   all             any
    "   block           (, {, [[, [{, etc.
    "   hor             horizontal movements
    "   insert          any command in Insert mode
    "   jump            far jumps
    "   mark            mark jumps
    "   percent         pair match
    "   quickfix        :cn, :crew, :make, etc.
    "   search          search for a pattern: /, n, *, gd, etc.
    "                   (not for a search pattern in a : command) Also for [s and ]s.
    "   tag             jumping to a tag: :ta, CTRL-T, etc.
    "   undo            undo or redo: u and CTRL-R
    set foldopen=hor,mark,percent,quickfix,search,tag,undo


    " fold methods for different filetypes
    autocmd FileType tmux,zsh,snippets setlocal foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType haskell setlocal foldmethod=marker foldmarker={{{,--\ }}}
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType json,json5 setlocal foldmethod=syntax
    autocmd FileType tex setlocal foldmethod=expr

    " TODO: Python folding
    " autocmd FileType python setlocal foldmethod=manual

    function! FoldOrSelect()
        if foldlevel(line('.')) == 0
            call feedkeys("vip")
        else
            call feedkeys("zazz")
        endif
    endfunction

    " Press Enter to toggle folding except in quickfix
    " nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : "call FoldOrSelect()"
    " nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"
    nnoremap <expr> <Tab> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"

    " Press Enter to create folding
    vnoremap <Tab> zf

" }}}

" { Buffer saving/loading/exit } {{{
    " auto save and restore
    set vop=folds,cursor,curdir  " save folds, cursor position, working directory only
    let blacklist = ['qf']
    autocmd BufWritePost,BufWinLeave *.* if index(blacklist, &ft) < 0 | mkview
    autocmd BufEnter *.* if index(blacklist, &ft) < 0 | silent! loadview

    " Auto search and clean trailing space after file written.
    autocmd BufWritePre * %s/\s\+$//e

    " And replace tab automatically
    autocmd BufWritePre * retab

    " save and (force) exit
    noremap Q :q<CR>
    noremap ! :q!<CR>
    noremap X :x<CR>
    nnoremap <Space>w :w<CR>
    nnoremap <Space>x :x<CR>
    autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | bdelete | endif

    function! QuitOrBufferDelete()
        let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
        let empty_name = (expand('%') == '')
        if (buf_len && empty_name)
            exec 'q'
        else
            exec 'bd!'
        endif
    endfunction
    nnoremap <silent> <Space>q :call QuitOrBufferDelete()<CR>
" }}}

" { Key mappings } {{{
    " view in middle while editing
    inoremap zz <C-o>zz

    " macros
    nnoremap T qt
    nnoremap t @t

    " jump between changes and view in middle
    nnoremap g; g;zz
    nnoremap g, g,zz
    nnoremap <C-o> <C-o>zz
    nnoremap <C-m> <C-i>zz

    " number increment: press <C-s>/<C-x> to increase/decrease 1
    nnoremap <C-s> <C-a>
    vnoremap <C-s> <C-a>

    " redo/undo
    nnoremap U <C-r>
    inoremap uu <Esc>u

    " break points
    inoremap , ,<C-g>u
    inoremap . .<C-g>u
    inoremap ! !<C-g>u
    inoremap ? ?<C-g>u

    " visual selection
    nnoremap vv <C-v>

    " select last pasted
    nnoremap gp `[v`]

    " Text editing
    inoremap aa <C-o>a

    " yy yank a line with line break, and Y yank a plain line
    nnoremap Y y$

    " { Browse } {{{
        " browse the following link
        nnoremap gx <cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>

        " open file stored in clipboard
        nnoremap <Space>o :e <C-r>+<CR>
    " }}}

    " { vimrc / lua } {{{
        nnoremap <Space>ve :e $MYVIMRC<CR>
        nnoremap <Space>vv :source $MYVIMRC<CR>
        nnoremap <Space>vl :luafile %<CR> :PackerCompile<CR>
    " }}}

    " { Movement with in line } {{{
        " begining & end
        nnoremap B ^
        nnoremap E g_
        vnoremap B ^
        vnoremap E g_

        " emacs-like
        inoremap <M-f> <C-o>w
        inoremap <M-b> <C-o>b
        inoremap <C-a> <C-o>I
        cnoremap <C-f> <Right>
        cnoremap <C-o> <C-f>
        cnoremap <C-b> <Left>
    " }}}

    " { Command mode mapping } {{{
        cnoremap <M-b> <S-Left>
        cnoremap <M-f> <S-Right>
        cnoremap <C-a> <Home>
    " }}}

    " { Dragging line vertically } {{{
        nnoremap <C-u> :m .-2<CR>
        nnoremap <C-d> :m .+1<CR>
        inoremap <C-u> <Esc>:m .-2<CR>gi
        inoremap <C-d> <Esc>:m .+1<CR>gi
        vnoremap <C-u> :m '<-2<CR>gv=gv
        vnoremap <C-d> :m '>+1<CR>gv=gv
    " }}}

    " { Dragging line horizontally } {{{
        nnoremap > >>
        nnoremap < <<

        " indent and re-select
        vnoremap > >gv
        vnoremap < <gv
    " }}}

    " { Page scrolling } {{{
        nnoremap <C-k> <C-u>
        nnoremap <C-j> <C-d>
        vnoremap <C-k> 5k
        vnoremap <C-j> 5j
    " }}}

    " { Escape key mapping } {{{
        " Deprecated
        nnoremap q  <Esc>
        nnoremap qq <Esc>
        vnoremap q  <Esc>
        inoremap qq <Esc>
    " }}}

" }}}

" { Windows/Buffers settings } {{{

    " jump between buffers
    nnoremap <Space><Tab> :b#<CR>

    " resizing
    nnoremap = <C-w>+
    nnoremap - <C-w>-
    nnoremap _ <C-w><
    nnoremap + <C-w>>

    " navigation
    nnoremap <Space>h     <C-w>h
    nnoremap <Space>l     <C-w>l
    nnoremap <Space>j     <C-w>j
    nnoremap <Space>k     <C-w>k
    " nnoremap <Tab>        <C-w><C-p>
    nnoremap <Space>e     <C-w><C-p>

    " split window
    set splitbelow splitright " specify the location
    nnoremap <Space>s :vsp \| b<Space>

" }}}

" { Location list } {{{
    function! ToggleLocationList(height)
        let n1 = winnr("$")
        exec "lwindow " . a:height
        let n2 = winnr("$")
        if n1 == n2
            lclose
        endif
    endfunction

    " Toggle location list
    nnoremap <silent> <F6> :call ToggleLocationList(5)<CR>
    nnoremap <silent> <Space>t :call ToggleLocationList(5)<CR>
    inoremap <silent> <F6> <Esc>:call ToggleLocationList(5)<CR>
" }}}

" { spell check } {{{
    " turn off by default
    set nospell

    " (Deprecated in nvim) store custom spell dictionary
    " set spellfile=~/.vim/spell/en.utf-8.add

    " make check supports English, Chinese, Japanese, Korean
    setlocal spelllang=en_us,cjk

    " auto spelling check for some file types
    autocmd BufRead,BufNewFile *.md,*.txt,*.tex,*.adoc if &l:buftype !=# 'help' | setlocal spell | endif

    " TODO
    inoremap <c-k> <c-g>u<Esc>[s1z=`]a<c-g>u

    " use <F8> to toggle spell check
    nnoremap <silent> <F8> :setlocal spell!<CR>
    inoremap <silent> <F8> <ESC>:setlocal spell!<CR>i
" }}}

" vim: foldmethod=marker
