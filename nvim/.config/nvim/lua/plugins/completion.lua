return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-e>'] = { function(cmp) cmp.show() end },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-y>'] = { 'accept', 'fallback' },
        -- ['<CR>'] = { function(cmp) cmp.accept() end },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        menu = {
          border = "rounded",
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "hrsh7th/cmp-buffer" },
  --     { "hrsh7th/cmp-path" },
  --     { "hrsh7th/cmp-cmdline" },
  --     { "hrsh7th/cmp-nvim-lua" },
  --     { "hrsh7th/cmp-calc" },
  --     { "saadparwaiz1/cmp_luasnip" },
  --     { "hrsh7th/cmp-cmdline" },
  --     { "onsails/lspkind.nvim" },
  --     { "saecki/crates.nvim" },
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           require("luasnip").lsp_expand(args.body)
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       formatting = {
  --         format = require("lspkind").cmp_format({
  --           mode = 'symbol', -- show only symbol annotations
  --           maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --           -- can also be a function to dynamically calculate max width such as
  --           -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
  --           ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --           show_labelDetails = true, -- show labelDetails in menu. Disabled by default
  --
  --           -- The function below will be called before any actual modifications from lspkind
  --           -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
  --           before = function(entry, vim_item)
  --             -- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
  --             vim_item.menu = ({
  --               nvim_lsp = "[LSP]",
  --               buffer = "[Buffer]",
  --               nvim_lua = "[Lua]",
  --               luasnip = "[Luasnip]",
  --               path = "[Path]",
  --               calc = "[Calc]",
  --               crates = "[Crates]",
  --             })[entry.source.name]
  --             return vim_item
  --           end,
  --         })
  --
  --       },
  --       mapping = {
  --         ["<C-p>"] = cmp.mapping.select_prev_item(),
  --         ["<C-n>"] = cmp.mapping.select_next_item(),
  --         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-c>"] = cmp.mapping.close(),
  --
  --         -- https://github.com/hrsh7th/cmp-cmdline/issues/42
  --         -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
  --         ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
  --
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       },
  --       sources = {
  --         { name = "luasnip" },
  --         { name = "nvim_lsp" },
  --         { name = "nvim_lua" },
  --         { name = "path" },
  --         { name = "calc" },
  --         { name = "crates" },
  --         {
  --           name = "buffer",
  --           option = {
  --             get_bufnrs = function()
  --               return vim.api.nvim_list_bufs()
  --             end,
  --           },
  --         },
  --       },
  --     })
  --
  --     -- `:` cmdline setup.
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --
  --     -- `/` cmdline setup.
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --   end,
  -- },
}
