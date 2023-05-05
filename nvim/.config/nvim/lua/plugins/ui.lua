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

return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dashboard").setup {
        theme = "hyper",
        config = {
          week_header = { enable = true },
          shortcut = {
            { desc = "Plugins",     action = "Lazy",                     key = "l" },
            { desc = "Find files",  action = "Telescope find_files",     key = "f" },
            { desc = "Grep string", action = "Telescope live_grep_args", key = "g" },
            { desc = "Quit",        action = "quitall",                  key = "q" },
          },
        },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local symbols = require("custom.symbols")
      local navic = require("nvim-navic")

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
            {
              navic.get_location,
              cond = navic.is_available,
            },
            function()
              return require("lsp-status").status()
            end,
          },
          lualine_x = {
            "location",
            "progress",
          },
          lualine_y = {
            {
              "diff",
              symbols = {
                added = " ",
                modified = "柳",
                removed = " ",
              },
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
        extensions = { "nvim-tree" },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup {
        input = {
          insert_only = false,
        },
      }
    end,
  },
  {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
        },
      })
    end,
    keys = {
      { "<C-l>", "<cmd>BufferLineCycleNext<cr>" },
      { "<C-h>", "<cmd>BufferLineCyclePrev<cr>" },
      { "L",     "<cmd>BufferLineMoveNext<cr>" },
      { "H",     "<cmd>BufferLineMovePrev<cr>" },
    },
  }
}
