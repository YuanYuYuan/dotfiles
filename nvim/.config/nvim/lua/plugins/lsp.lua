local servers = {
  eslint = {},
  -- ts_ls = {},
  sqlls = {},
  gopls = {},
  pyright = {},
  -- ccls = {
  --   init_options = {
  --     clang = {
  --       extraArgs = { "-std=c++17" },
  --     },
  --   },
  -- },
  clangd = {},
  cmake = {},
  texlab = {},
  jsonls = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
  lemminx = {
    cmd = { "lemminx" },
  },
  html = {},
  docker_compose_language_service = {},
  dockerls = {},
  lua_ls = {
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
        hint = { enable = true },
      },
    },
  },
  rust_analyzer = {
    cmd = vim.lsp.rpc.connect("127.0.0.1", 27631),
    settings = {
      ["rust-analyzer"] = {
        -- ra-multiplex
        lspMux = {
          version = "1",
          method = "connect",
          server = "rust-analyzer",
        },

        -- -- checkOnSave = false,
        -- check = {
        --   allTargets = false,
        --   -- overrideCommand = {
        --   --     "cargo",
        --   --     "check",
        --   -- }
        --   -- overrideCommand = {
        --   --     "cargo",
        --   --     "clippy",
        --   --     "--message-format=json",
        --   --     "--",
        --   --     "-D warnings",
        --   -- }
        -- },
        cargo = {
          features = "all",
        },
      },
    },
  },
  kotlin_language_server = {},
  nushell = {},
  nil_ls = {},
}

if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<Space><Space>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle inlay hints" })
end

local config_lspconfig = function()
  local lspconfig = require("lspconfig")

  require("lspconfig.ui.windows").default_options.border = "rounded"
  -- lspconfig.util.default_config =
  --     vim.tbl_extend("force", lspconfig.util.default_config, {
  --       capabilities = require("cmp_nvim_lsp").default_capabilities(),
  --     })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- nvim-ufo
  capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
  }
  for server, config in pairs(servers) do
    config.autostart = true
    config.capabilities = capabilities
    config.on_attach = function(_client, _bufnr)
      vim.lsp.inlay_hint.enable()
    end
    lspconfig[server].setup(config)
  end

  -- local rt = require("rust-tools")
  -- rt.setup({
  --   server = {
  --     autostart = true,
  --     on_attach = function(_, bufnr)
  --       vim.keymap.set("n", "<Space>rk", rt.hover_actions.hover_actions, { buffer = bufnr })
  --       vim.keymap.set("n", "<Space>rc", rt.code_action_group.code_action_group, { buffer = bufnr })
  --       vim.keymap.set("n", "<Space>re", rt.expand_macro.expand_macro, { buffer = bufnr })
  --     end,
  --     capabilities = capabilities,
  --     settings = {
  --       ["rust-analyzer"] = {
  --         check = {
  --           -- command = "clippy",
  --           allTargets = false,
  --           -- overrideCommand = {
  --           --     "cargo",
  --           --     "clippy",
  --           --     "--message-format=json-diagnostic-rendered-ansi",
  --           --     "--fix",
  --           --     "--allow-dirty"
  --           -- }
  --         },
  --       },
  --     },
  --   },
  -- })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "ray-x/lsp_signature.nvim" },
      { "simrat39/rust-tools.nvim" },
    },
    config = config_lspconfig,
  },
}
