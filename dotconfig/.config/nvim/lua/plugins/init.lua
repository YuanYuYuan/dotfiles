vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require 'gitsigns'.setup()
      vim.cmd [[
        nnoremap <Space>gb :Gitsigns blame_line<CR>
      ]]
    end
  }
  use { 'mattn/emmet-vim',
    config = vim.cmd [[
      let g:user_emmet_leader_key=','
    ]]
  }
  use 'AndrewRadev/switch.vim'
  use { 'habamax/vim-asciidoctor',
    config = vim.cmd [[
      let g:asciidoctor_folding = 1
      let g:asciidoctor_fold_options = 1
      let g:asciidoctor_syntax_conceal = 1
      let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript']

      autocmd FileType asciidoc setlocal foldmethod=expr
      autocmd FileType asciidoc setlocal foldexpr=AsciidoctorFold()
    ]]
  }
  use 'liuchengxu/vista.vim'
  use 'skywind3000/asyncrun.vim'
  -- Switch between single-line and multiline forms of code
  use 'AndrewRadev/splitjoin.vim'
  use 'mg979/vim-visual-multi'
  use { 'godlygeek/tabular',
    config = vim.cmd [[
        vnoremap \ :Tabularize /
    ]]
  }
  -- use { 'junegunn/vim-easy-align',
  --   config = vim.cmd [[
  --     xmap ga <Plug>(EasyAlign)
  --     nmap ga <Plug>(EasyAlign)
  --   ]]
  -- }
  use { 'kyazdani42/nvim-tree.lua',
    config = function()
      require'nvim-tree'.setup {
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        update_focused_file = {
          enable = true,
          update_cwd  = true,
        },
        view = {
          side = 'left',
          hide_root_folder = false,
          auto_resize = true
        }
      }
      vim.cmd [[
        nnoremap <F1> :NvimTreeToggle<CR>
      ]]
    end
  }
  use { 'iamcco/markdown-preview.nvim',
    ft = "markdown",
    run = 'cd app && yarn install',
    config = vim.cmd [[
      let g:mkdp_auto_close = 0
      autocmd FileType markdown inoremap <buffer> <silent> <F3> <Esc>:MarkdownPreview<CR>
      autocmd FileType markdown nnoremap <buffer> <silent> <F3> :MarkdownPreview<CR>
    ]]
  }
  use 'alvan/vim-closetag'
  use { 'lukas-reineke/indent-blankline.nvim',
    config = vim.cmd [[
      let g:indent_blankline_use_treesitter = v:true
    ]]
  }

  -- colorscheme
  use 'YuanYuYuan/zephyr-nvim'

  -- A high-performance color highlighter for Neovim
  use { 'norcalli/nvim-colorizer.lua',
    config = [[require 'colorizer'.setup()]]
  }

  use { 'scrooloose/nerdcommenter',
    config = vim.cmd [[
      " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims            = 1

      " Disable commenting empty lines
      let g:NERDCommentEmptyLines      = 0

      " use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs        = 1

      " trim trailing whitespace
      let g:NERDTrimTrailingWhitespace = 1

      " left align the comment
      let g:NERDDefaultAlign           = 'left'

      " wisely comment on a region
      let g:NERDToggleCheckAllLines = 1

      " delimiters for different file type
      let g:NERDCustomDelimiters = { 'json5': { 'left': '//' } }

      nmap <BS> <plug>NERDCommenterToggle
      vmap <BS> <plug>NERDCommenterToggle
    ]]
  }
  use { 'YuanYuYuan/mru',
    config = vim.cmd [[
      nnoremap <Space>f :MRU<CR>
    ]]
  }
  use { 'tpope/vim-surround',
    config = vim.cmd [[
      let g:surround_no_mappings = 1
      nmap ds <Plug>Dsurround
      nmap cs <Plug>Csurround
      xmap s <Plug>VSurround
      xmap gs <Plug>VgSurround
    ]]
  }
  use { 'jiangmiao/auto-pairs',
    config = vim.cmd [[
      " Disable some shortcuts
      let g:AutoPairsShortcutBackInsert = ''
      let g:AutoPairsShortcutToggle = ''
    ]]
  }
  use { 'hrsh7th/nvim-compe',
    config = function()
      require'plugins.compe'
      vim.cmd [[
        set completeopt+=menuone,noselect
      ]]
    end
  }
  use 'kyazdani42/nvim-web-devicons'
  use { 'akinsho/nvim-bufferline.lua',
    config = [[require'plugins.bufferline']]
  }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'plugins.treesitter']]
  }
  use 'nvim-treesitter/playground'

  use { 'lervag/vimtex',
    ft = 'tex',
    config = vim.cmd [[
      " viewer
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_compiler_progname = 'nvr'

      let maplocalleader = ";"

      " avoid plaintex
      let g:tex_flavor='latex'

      let g:vimtex_view_method = 'zathura'

      " enable folding
      " let g:vimtex_fold_manual=0
      let g:vimtex_fold_enabled=1

      let g:vimtex_quickfix_enabled = 0

      autocmd BufWinLeave *.tex silent! VimtexClean
    ]]
  }
  use 'itchyny/vim-cursorword'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'FooSoft/vim-argwrap',
    config = vim.cmd [[
      nnoremap <silent> <Space>a :ArgWrap<CR>
    ]]
  }
  use { 'simrat39/rust-tools.nvim',
    -- ft = 'rust',
    config = function()
      require('plugins.rust')
      vim.cmd [[
        nnoremap <F3> :RustRunnables<CR>
        inoremap <F3> <Esc>:RustRunnables<CR>
      ]]
    end
  }
  use { 'SirVer/ultisnips',
    config = vim.cmd [[
      let g:UltiSnipsExpandTrigger="<c-e>"
      let g:UltiSnipsJumpForwardTrigger="<CR>"
      let g:UltiSnipsJumpBackwardTrigger="<S-CR>"
      let g:UltiSnipsSnippetDirectories=['snips']
      snoremap qq <Esc>
      nnoremap <silent> <F4> :exec 'edit $HOME/.config/nvim/snips/' .  &ft . '.snippets' <CR>
    ]]
  }
  -- use 'hrsh7th/vim-vsnip'
  -- use { 'hrsh7th/vim-vsnip-integ',
  --   config = vim.cmd [[
  --     let g:vsnip_snippet_dir = '$XDG_CONFIG_HOME/nvim/snips'
  --     imap <expr> <C-e> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-e>'
  --     smap <expr> <C-e> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-e>'
  --     nnoremap <F4> :VsnipOpenEdit<CR>
  --     inoremap <F4> <Esc>:VsnipOpenEdit<CR>
  --   ]]
  -- }


  -- lsp
  use { 'neovim/nvim-lspconfig',
    config = vim.cmd [[
      nnoremap <F2> :LspStart<CR>
      inoremap <F2> <Esc>:LspStart<CR>
    ]]
  }
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  use { 'nvim-lua/lsp-status.nvim',
    config = [[require'plugins.lsp']]
  }

  use 'nvim-telescope/telescope.nvim'
  use { 'glepnir/galaxyline.nvim',
    branch = 'main',
    config = [[require'plugins.statusline']]
  }
end)
