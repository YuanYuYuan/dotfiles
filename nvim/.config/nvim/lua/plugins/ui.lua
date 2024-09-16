-- Define basic symobls
local symbols = require("custom.symbols")
for suffix, icon in pairs({
  Error = symbols.signs.error,
  Warn = symbols.signs.warn,
  Info = symbols.signs.info,
  Hint = symbols.signs.hint,
}) do
  local hl = "DiagnosticSign" .. suffix
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config_lualine = function()
  vim.opt.laststatus = 3
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "onedark",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "filetype",
          icon_only = true,
        },
        {
          "filename",
          path = 4,
        },
      },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = symbols.signs,
        },
        "aerial",
      },
      lualine_x = {
        "location",
        "progress",
      },
      lualine_y = {
        {
          "diff",
          symbols = symbols.diff,
        },
      },
      lualine_z = {
        "branch",
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      "quickfix",
      "neo-tree",
      "fugitive",
      "quickfix",
      "toggleterm",
      "lazy",
      "man",
    },
  })
end

return {
  -- nvim-pqf
  {
    "yorickpeterse/nvim-pqf",
    config = function()
      require("pqf").setup()
    end,
  },

  -- dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-neo-tree/neo-tree.nvim" },
    },
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = { enable = true },
          shortcut = {
            { desc = "Tree", action = "NeoTreeFloatToggle", key = "t" },
            { desc = "Lazy", action = "Lazy", key = "l" },
            { desc = "Find files", action = "Telescope find_files", key = "f" },
            { desc = "Grep string", action = "Telescope live_grep", key = "g" },
            { desc = "Old files", action = "Telescope oldfiles", key = "o" },
            { desc = "Quit", action = "quitall", key = "q" },
          },
        },
      })
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    lazy = false,
    -- Comment out due to the gloabl status issue
    -- event = "VeryLazy",
    config = config_lualine,
  },

  -- dressing
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
        },
      })
    end,
  },

  -- bufferline
  {
    "akinsho/nvim-bufferline.lua",
    lazy = false,
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          indicator = {
            style = "underline",
          },
        },
      })
    end,
    keys = {
      { "<C-l>", "<cmd>BufferLineCycleNext<cr>" },
      { "<C-h>", "<cmd>BufferLineCyclePrev<cr>" },
      { "L", "<cmd>BufferLineMoveNext<cr>" },
      { "H", "<cmd>BufferLineMovePrev<cr>" },
    },
  },

  -- neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("neo-tree").setup({
        -- global config
        popup_border_style = "rounded",
        window = {
          mappings = {
            ["l"] = "open",
            ["<Tab>"] = "next_source",
            ["<S-Tab>"] = "prev_source",
          },
        },

        -- filesystem source config
        filesystem = {
          bind_to_cwd = false,
          filtered_items = {
            hide_dotfiles = false,
          },
          window = {
            mappings = {
              ["h"] = "navigate_up",
            },
          },
        },

        -- buffers source config
        buffers = {
          bind_to_cwd = false,
          window = {
            mappings = {
              ["h"] = "navigate_up",
            },
          },
        },

        -- auto close on open file
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              -- auto close
              -- vimc.cmd("Neotree close")
              -- OR
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
        },
      })
    end,
    keys = {
      { "<Space>1", "<cmd>Neotree last bottom toggle<cr>" },
    },
  },

  -- fidget
  {
    "j-hui/fidget.nvim",
    -- lazy = false,
    config = function()
      require("fidget").setup({
        notification = {
          -- Transparency
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },

  -- stevearc/aerial.nvim, show tags of variables
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      vim.keymap.set({ "n" }, "<Space>2", "<cmd>AerialToggle<CR>")
    end,
  },

  -- indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        exclude = {
          filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "gitcommit",
            "TelescopePrompt",
            "TelescopeResults",
            "dashboard",
            "",
          }
        }
      })
    end,
  },

  -- RRethy/vim-illuminate: hightlight the other uses
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure()
    end
  },

  -- folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        highlight = {
          -- vimgrep regex, supporting the pattern TODO(name):
          pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
        },
        search = {
          -- ripgrep regex, supporting the pattern TODO(name):
          pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
        }
      })

    end
  },

  -- rcarriga/nvim-notify
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup()
      vim.notify = require("notify")
    end
  }
}
