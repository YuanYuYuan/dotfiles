return {
  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<BS>",
        },
        opleader = {
          line = "<BS>",
        },
      })
      local ft = require("Comment.ft")
      ft.set("json5", "//%s")
    end,
  },

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "s",
        },
      })
    end,
  },

  -- treesj
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    keys = {
      {
        "<space>a",
        function()
          require("treesj").toggle()
        end,
      },
    },
  },

  -- mini.align
  {
    "echasnovski/mini.align",
    version = "*",
    config = function()
      require("mini.align").setup()
    end,
  },

  -- leap.nvim
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
    end
  },

  -- For Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function()
      require('render-markdown').setup({
        completions = { blink = { enabled = true } },
        -- Render for all modes
        render_modes = true,
      })
    end,
  },
  {
    'brianhuster/live-preview.nvim',
  },

  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup()
    end,
  },
}
