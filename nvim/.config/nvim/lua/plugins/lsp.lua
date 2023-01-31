local lsp_config = require('lspconfig')
local lsp_status = require('lsp-status')

require ('lsp_signature').setup()

local symbols = require('plugins.symbols')

lsp_status.config {
  -- kind_labels = symbols.kind_labels,
  diagnostics = false,
  status_symbol = '',
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ['start'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
        ['end'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
      }

      return require('lsp-status/util').in_range(cursor_pos, value_range)
    end
  end,
  current_function = true
}

lsp_status.register_progress()

-- disable inline diagnostic
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true
  }
)

local navic = require('nvim-navic')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  navic.attach(client, bufnr)

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

  -- local mapping = {
  --   ['K'] = vim.lsp.buf.hover,
  --   ['[e'] = vim.diagnostic.goto_prev,
  --   [']e'] = vim.diagnostic.goto_next,
  --   ['<Space><Space>e'] = vim.diagnostic.setloclist,
  -- }


  -- -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- -- buf_set_keymap('n', '<space><space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- vim.keymap.set('n', '<space><space>e', vim.diagnostic.setloclist, opts)
  -- buf_set_keymap('n', '<space>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- -- buf_set_keymap('n', '<space>gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', '<space>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- buf_set_keymap('n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<space>gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>gw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- -- vim.cmd('autocmd CursorHold * lua vim.lsp.buf.signature_help()')
  -- -- vim.cmd('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
  -- -- vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
  -- -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- -- buf_set_keymap('n', '<Space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- -- buf_set_keymap('n', '<Space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
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
        extraArgs = { "-std=c++17" }
      }
    }
  },
  -- hls = {},
  cmake = {},
  texlab = {},
  sumneko_lua = {
    cmd = {'lua-language-server'};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  },
  jsonls = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
  },
  julials = {},
  lemminx = {
    cmd = { "/usr/bin/lemminx" }
  },
  html = {},
}


-- from cmp_nvim_lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for server, config in pairs(servers) do
  config.autostart = true
  config.on_attach = on_attach
  config.capabilities = capabilities
  lsp_config[server].setup(config)
end

require('rust-tools').setup{
  server = {
    autostart = false,
    on_attach = on_attach,
    capabilities = capabilities
  }
}

-- set lsp diagnostic sign: neovim 0.6.1
for sign, config in pairs({
  DiagnosticSignError = {text = symbols.signs.error, texthl = 'DiagnosticSignError'},
  DiagnosticSignWarn  = {text = symbols.signs.warn, texthl  = 'DiagnosticSignWarn'},
  DiagnosticSignInfo  = {text = symbols.signs.info, texthl  = 'DiagnosticSignInfo'},
  DiagnosticSignHint  = {text = symbols.signs.hint, texthl  = 'DiagnosticSignHint'},
}) do vim.fn.sign_define(sign, config) end

local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
  hls = {
    on_attach = function(client, bufnr)
      local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
      -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
    end,
  },
}
-- Suggested keymaps that do not depend on haskell-language-server
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<Space>rr', ht.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<Space>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set('n', '<Space>rq', ht.repl.quit, def_opts)
