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
    -- {
    --     "akinsho/nvim-bufferline.lua",
    --     lazy = false,
    --     config = function()
    --         require("bufferline").setup({
    --             options = {
    --                 diagnostics = "nvim_lsp",
    --                 indicator = {
    --                     style = "underline",
    --                 },
    --             },
    --         })
    --     end,
    --     keys = {
    --         { "<C-l>", "<cmd>BufferLineCycleNext<cr>" },
    --         { "<C-h>", "<cmd>BufferLineCyclePrev<cr>" },
    --         { "L",     "<cmd>BufferLineMoveNext<cr>" },
    --         { "H",     "<cmd>BufferLineMovePrev<cr>" },
    --     },
    -- },

    -- yazi.nvim
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        dependencies = {
            "folke/snacks.nvim"
        },
        keys = {
            {
                "<Space>1",
                mode = { "n", "v" },
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
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
            require('illuminate').configure({
                large_file_cutoff = 1000,
            })
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
            require("notify").setup {
                background_colour = "#000000"
            }
            vim.notify = require("notify")
        end
    },

    {
        'echasnovski/mini.hipatterns',
        version = '*',
        config = function()
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end
    },
}
