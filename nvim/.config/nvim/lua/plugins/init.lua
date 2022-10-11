local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- vim.api.nvim_create_autocmd({'BufWritePost'}, {
--   pattern = {'init.lua'},
--   command = 'source <afile> | PackerCompile',
-- })


local packer = require('packer')
local use = packer.use

local startup = function()
  use 'wbthomason/packer.nvim'
  use {'gutenye/json5.vim', ft = 'markdown'}

  use { 'akinsho/toggleterm.nvim',
    config = function() require('plugins.toggleterm') end
  }
  use {
      'SmiteshP/nvim-navic',
      requires = "neovim/nvim-lspconfig"
  }

  -- Git
  use 'tpope/vim-fugitive'
  -- use 'lewis6991/gitsigns.nvim'

  use { 'mattn/emmet-vim',
    config = vim.cmd [[
      let g:user_emmet_leader_key=','
    ]],
    -- ft = 'html',
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
      vim.api.nvim_set_keymap('n', '<F2>', '<cmd>Vista!!<CR>', {noremap = true})
    end
  }
  use 'skywind3000/asyncrun.vim'
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
            hint = '',
            info = '',
            warning = '',
            error = '',
          }
        },
        -- -- XXX: Disable since auto opening while switching buffers
        -- update_focused_file = {
        --   enable = true,
        --   update_cwd  = true,
        -- },
        view = {
          side = 'left',
          hide_root_folder = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          }
        }
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
  use { 'lukas-reineke/indent-blankline.nvim',
    config = vim.cmd [[
      let g:indent_blankline_use_treesitter = v:true
    ]]
  }

  -- colorscheme
  use 'EdenEast/nightfox.nvim'

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
  }

  use { 'lervag/vimtex',
    ft = 'tex',
    config = [[require('plugins.vimtex')]]
  }

  -- -- TODO: Disable since too slow
  -- use 'itchyny/vim-cursorword'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'FooSoft/vim-argwrap',
    config = vim.cmd [[
      nnoremap <silent> <Space>a :ArgWrap<CR>
    ]]
  }
  use { 'SirVer/ultisnips',
    ft = {
      'tex',
      -- 'asciidoctor',
      -- 'markdown'
    },
    config = vim.cmd [[
      let g:UltiSnipsExpandTrigger='<c-e>'
      let g:UltiSnipsJumpForwardTrigger='<CR>'
      let g:UltiSnipsJumpBackwardTrigger='<S-CR>'
      let g:UltiSnipsSnippetDirectories=['snips']
      snoremap qq <Esc>
      " nnoremap <silent> <F4> :exec 'edit $HOME/.config/nvim/snips/' .  &ft . '.snippets' <CR>
    ]]
  }

  use {'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*'}
  use 'saadparwaiz1/cmp_luasnip'

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
      vim.api.nvim_set_keymap('n', '<F6>', '<cmd>TroubleToggle<cr>', {silent = true, noremap = true})
    end
  }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      require('plugins.cmp')
    end
  }

  use 'stevearc/dressing.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-frecency.nvim',
    requires = {'tami5/sqlite.lua'}
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.statusline')
    end
  }
  use 'arkav/lualine-lsp-progress'

  -- -- improve highlight searching
  -- use { 'kevinhwang91/nvim-hlslens',
  --   config = function()
  --     require('hlslens').setup({
  --       calm_down = true,
  --     })
  --   end
  -- }

  use { 'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
      -- vim.cmd [[
      --   hi default link HlSearchLens IncSearch
      -- ]]
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end

packer.startup {
  startup,
  config = {
    max_jobs = tonumber(vim.fn.system 'nproc 2>/dev/null || echo 4'),
  },
  -- rocks = {
  --   'base64',
  -- },
}

-- require('plugins.gitsigns')
require('plugins.config_telescope')
require('plugins.colorscheme')
require('plugins.treesitter')
require('plugins.luasnip')
