local lsp_config = require("lspconfig")
local lsp_status = require("lsp-status")

require("lsp_signature").setup()

local symbols = require("plugins.symbols")

lsp_status.config({
  -- kind_labels = symbols.kind_labels,
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

-- inline diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
})

local navic = require("nvim-navic")
local inlayhints = require("lsp-inlayhints")
inlayhints.setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  navic.attach(client, bufnr)
  inlayhints.on_attach(client, bufnr)
  client.config.flags.debounce_text_changes = 500

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- -- Mappings.
  -- local opts = {
  --   buffer=bufnr,
  --   noremap=true,
  --   silent=true
  -- }
end

local servers = {
  eslint = {},
  tsserver = {},
  sqls = {},
  gopls = {},
  pyright = {},
  -- clangd = {},
  ccls = {
    init_options = {
      clang = {
        extraArgs = { "-std=c++17" },
      },
    },
  },
  -- hls = {},
  cmake = {},
  texlab = {},
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
  jsonls = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
  julials = {},
  lemminx = {
    cmd = { "/usr/bin/lemminx" },
  },
  html = {},
  rust_analyzer = {
    -- cmd = { "ra-multiplex" },
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
}

-- from cmp_nvim_lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, config in pairs(servers) do
  config.autostart = true
  config.on_attach = on_attach
  config.capabilities = capabilities
  lsp_config[server].setup(config)
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

for suffix, icon in pairs({
  Error = symbols.signs.error,
  Warn = symbols.signs.warn,
  Info = symbols.signs.info,
  Hint = symbols.signs.hint,
}) do
  local hl = "DiagnosticSign" .. suffix
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local ht = require("haskell-tools")
local def_opts = { noremap = true, silent = true }
ht.setup({
  hls = {
    on_attach = function(client, bufnr)
      local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
      vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
      -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
    end,
  },
})
-- Suggested keymaps that do not depend on haskell-language-server
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<Space>rr", ht.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<Space>rf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set("n", "<Space>rq", ht.repl.quit, def_opts)
