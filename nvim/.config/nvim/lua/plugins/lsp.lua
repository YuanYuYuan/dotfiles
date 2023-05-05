local servers = {
  eslint = {},
  tsserver = {},
  sqlls = {},
  gopls = {},
  pyright = {},
  ccls = {
    init_options = {
      clang = {
        extraArgs = { "-std=c++17" },
      },
    },
  },
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

local setup_lspconfig = function()
  local lspconfig = require "lspconfig"

  require("lspconfig.ui.windows").default_options.border = "rounded"
  lspconfig.util.default_config =
      vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

  local navic = require("nvim-navic")
  local inlayhints = require("lsp-inlayhints")
  inlayhints.setup()

  local on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    inlayhints.on_attach(client, bufnr)
    client.config.flags.debounce_text_changes = 500
  end

  for server, config in pairs(servers) do
    config.autostart = true
    config.on_attach = on_attach
    lspconfig[server].setup(config)
  end

  -- require("mason-lspconfig").setup_handlers {
  --   function(server_name) lspconfig[server_name].setup {} end,
  -- }

  local lsp_status = require("lsp-status")
  lsp_status.config({
    diagnostics = false,
    status_symbol = "",
    select_symbol = function(cursor_pos, symbol)
      if symbol.valueRange then
        local value_range = {
          ["start"] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[1]) },
          ["end"] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[2]) },
        }

        return require("lsp-status/util").in_range(cursor_pos, value_range)
      end
    end,
    current_function = true,
  })
  lsp_status.register_progress()
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup()
        end,
      },
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          {"ray-x/lsp_signature.nvim"},
          {"nvim-lua/lsp-status.nvim"},
          {"lvimuser/lsp-inlayhints.nvim"},
          {"SmiteshP/nvim-navic"},
        },
        config = setup_lspconfig,
      },
    },
  },
}
