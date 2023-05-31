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
        "filetype",
      },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = symbols.signs,
        },
        { "navic" },
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
  -- dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "loichyan/neo-tree.nvim" },
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
    event = "VeryLazy",
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
    -- "nvim-neo-tree/neo-tree.nvim",
    "loichyan/neo-tree.nvim",
    branch = "fix-obsolete-icons",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("neo-tree").setup({
        popup_border_style = "rounded",
        filesystem = {
          window = {
            mappings = {
              ["h"] = "navigate_up",
              ["l"] = "open",
            },
          },
        },
      })
    end,
    keys = {
      { "<Space>1", "<cmd>NeoTreeFloatToggle<cr>" },
    },
  },

  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      vim.opt.list = true
      -- vim.opt.listchars:append("space:⋅")
      -- vim.opt.listchars:append("eol:↴")
      require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        -- show_current_context_start = true,
      })
    end,
  },

  -- fidget
  {
    "j-hui/fidget.nvim",
    lazy = false,
    config = function()
      require("fidget").setup({
        text = {
          spinner = "dots",
        },
        -- Transparency
        window = {
          blend = 0,
        },
      })
    end,
  },

  -- symbols-outline
  {
    -- "simrat39/symbols-outline.nvim",
    "loichyan/symbols-outline.nvim",
    branch = "fix-obsolete-icons",
    config = function()
      require("symbols-outline").setup()
      vim.keymap.set({ "n" }, "<Space>2", "<cmd>SymbolsOutline<cr>")
    end,
  },
}
