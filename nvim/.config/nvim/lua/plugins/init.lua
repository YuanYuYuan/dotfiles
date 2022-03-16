local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'rhysd/conflict-marker.vim'
  use { 'gutenye/json5.vim',
    ft = 'markdown',
  }

  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

          -- Actions
          map('n', '<leader>gp', gs.preview_hunk)
          map('n', '<leader>gb', function() gs.blame_line() end)
          map('n', '<leader>gd', gs.diffthis)
          -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          -- map('n', '<leader>hS', gs.stage_buffer)
          -- map('n', '<leader>hu', gs.undo_stage_hunk)
          -- map('n', '<leader>hR', gs.reset_buffer)
          -- map('n', '<leader>tb', gs.toggle_current_line_blame)
          -- map('n', '<leader>hd', gs.diffthis)
          -- map('n', '<leader>hD', function() gs.diffthis('~') end)
          -- map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
      -- vim.cmd [[
      --   nnoremap <Space>gb :Gitsigns blame_line<CR>
      -- ]]
    end
  }
  use { 'mattn/emmet-vim',
    config = vim.cmd [[
      let g:user_emmet_leader_key=','
    ]],
    ft = 'html',
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
    ]],
    ft = 'asciidoctor',
  }
  use { 'liuchengxu/vista.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<Space><Space>v', '<cmd>Vista!!<CR>', {noremap = true})
    end
  }
  use 'skywind3000/asyncrun.vim'
  -- use 'mg979/vim-visual-multi'
  use { 'godlygeek/tabular',
    config = vim.cmd [[
        vnoremap \ :Tabularize /
    ]]
  }
  use 'simrat39/rust-tools.nvim'
  use { 'kyazdani42/nvim-tree.lua',
    config = function()
      require'nvim-tree'.setup {
        git = {
          enable = false,
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
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
        },
      }
      -- vim.g["nvim_tree_quit_on_open"] = 1
      vim.cmd [[
        nnoremap <F1> :NvimTreeToggle<CR>
      ]]
    end
  }
  use { 'iamcco/markdown-preview.nvim',
    ft = 'markdown',
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

  -- -- colorscheme
  -- use 'YuanYuYuan/zephyr-nvim'
  -- use 'joshdick/onedark.vim'
  use { 'EdenEast/nightfox.nvim',
    config = function ()
      local nightfox = require('nightfox')
      nightfox.setup({
        transparent = false,
        groups = {
          Folded = { bg = "${none}"},
        }
      })
    end
  }

  -- -- -- A high-performance color highlighter for Neovim
  -- use { 'norcalli/nvim-colorizer.lua',
  --   config = [[require 'colorizer'.setup()]]
  -- }

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
  -- use { 'yegappan/mru',
  --   config = vim.cmd [[
  --     nnoremap <Space>f :MRU<CR>
  --   ]]
  -- }
  use { 'tpope/vim-surround',
    config = vim.cmd [[
      let g:surround_no_mappings = 1
      nmap ds <Plug>Dsurround
      nmap cs <Plug>Csurround
      xmap s <Plug>VSurround
      xmap gs <Plug>VgSurround
    ]]
  }
  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  use 'kyazdani42/nvim-web-devicons'
  use { 'akinsho/nvim-bufferline.lua',
    config = [[require'plugins.bufferline']]
  }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    -- config = [[require('plugins.treesitter')]]
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true,              -- false will disable the whole extension
          -- disable = { "tex"},  -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          -- additional_vim_regex_highlighting = true,
        },
      }
    end
  }
  -- -- use 'nvim-treesitter/playground'

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
  -- use { 'SirVer/ultisnips',
  --   ft = {
  --     'tex',
  --     -- 'asciidoctor',
  --     'markdown'
  --   },
  --   config = vim.cmd [[
  --     let g:UltiSnipsExpandTrigger="<c-e>"
  --     let g:UltiSnipsJumpForwardTrigger="<CR>"
  --     let g:UltiSnipsJumpBackwardTrigger="<S-CR>"
  --     let g:UltiSnipsSnippetDirectories=['snips']
  --     snoremap qq <Esc>
  --     nnoremap <silent> <F4> :exec 'edit $HOME/.config/nvim/snips/' .  &ft . '.snippets' <CR>
  --   ]]
  -- }
  use { 'hrsh7th/vim-vsnip',
    config = function()
      vim.g['vsnip_snippet_dir'] = '$XDG_CONFIG_HOME/nvim/vsnip'
      vim.cmd [[
        nmap <C-e> <Plug>(vsnip-cut-text)
        xmap <C-e> <Plug>(vsnip-cut-text)
      ]]
    end
  }
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
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim'
  use { 'nvim-lua/lsp-status.nvim',
    config = function()
      require('plugins.lsp')
    end
  }

  -- cmp / lspkind
  use { 'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        use_diagnostic_signs = true,
        auto_close = true,
      }
      vim.api.nvim_set_keymap("n", "<F2>", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
    end
  }
  use { 'tzachar/cmp-tabnine',
    run='./install.sh'
  }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.cmp')
    end
  }


  use { 'nvim-telescope/telescope.nvim',
    config = function()
      vim.cmd [[
        nnoremap <leader>f         <cmd> lua require('telescope.builtin').oldfiles()<cr>
        nnoremap <leader>ff        <cmd> lua require('telescope.builtin').find_files()<cr>
        nnoremap <leader>fg        <cmd> lua require('telescope.builtin').git_files()<cr>
        nnoremap <leader>fb        <cmd> lua require('telescope.builtin').buffers()<cr>
        nnoremap <leader>fh        <cmd> lua require('telescope.builtin').help_tags()<cr>
        nnoremap <leader><leader>a <cmd> lua require('telescope.builtin').lsp_code_actions()<cr>
      ]]
      require'telescope'.setup{
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
        }
      }
    end
  }
  use {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require'telescope'.load_extension('frecency')
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fq",
        "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
        {noremap = true, silent = true}
      )
    end,
    requires = {'tami5/sqlite.lua'}
  }
  use { 'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.statusline')
    end
  }
  use 'arkav/lualine-lsp-progress'

  -- improve highlight searching
  use { 'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        calm_down = true,
      })
    end
  }
  use { 'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
      vim.cmd [[
        hi default link HlSearchLens IncSearch
      ]]
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
