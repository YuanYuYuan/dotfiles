local servers = {
  eslint = {},
  tsserver = {},
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
    cmd = { "/usr/bin/lemminx" },
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
      },
    },
  },
  rust_analyzer = {},
}

local config_lspconfig = function()
  local lspconfig = require "lspconfig"

  require("lspconfig.ui.windows").default_options.border = "rounded"
  -- lspconfig.util.default_config =
  --     vim.tbl_extend("force", lspconfig.util.default_config, {
  --       capabilities = require("cmp_nvim_lsp").default_capabilities(),
  --     })

  local navic = require("nvim-navic")

  local inlayhints = require("lsp-inlayhints")
  inlayhints.setup()

  local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
        print("navic is loaded")
    end
    inlayhints.on_attach(client, bufnr)
    client.config.flags.debounce_text_changes = 500
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  for server, config in pairs(servers) do
    config.autostart = true
    config.on_attach = on_attach
    config.capabilities = capabilities
    lspconfig[server].setup(config)
  end

  local rt = require("rust-tools")
  rt.setup({
    server = {
      autostart = true,
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<Space>rk", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<Space>rc", rt.code_action_group.code_action_group, { buffer = bufnr })
        vim.keymap.set("n", "<Space>re", rt.expand_macro.expand_macro, { buffer = bufnr })
      end,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          check = {
            -- command = "clippy",
            allTargets = false,
            -- overrideCommand = {
            --     "cargo",
            --     "clippy",
            --     "--message-format=json-diagnostic-rendered-ansi",
            --     "--fix",
            --     "--allow-dirty"
            -- }
          },
        },
      },
    },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "ray-x/lsp_signature.nvim" },
      { "lvimuser/lsp-inlayhints.nvim" },
      { "SmiteshP/nvim-navic" },
      { "simrat39/rust-tools.nvim" },
    },
    config = config_lspconfig,
  },
}
