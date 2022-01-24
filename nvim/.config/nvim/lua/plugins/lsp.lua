local lsp_config = require('lspconfig')
local lsp_status = require('lsp-status')
local lsp_kind = require('lspkind')
local map = vim.api.nvim_set_keymap

require ('lsp_signature').setup()

local kind_symbols = require('plugins.kind_symbols')

lsp_status.config {
  kind_labels = kind_symbols,
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
lsp_kind.init {symbol_map = kind_symbols}

-- disable inline diagnostic
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true
  }
)



-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Space><Space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<Space>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Space>gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Space>gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<Space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Space>gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Space>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Space>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Space>gw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.cmd('autocmd CursorHold * lua vim.lsp.buf.signature_help()')
  -- vim.cmd('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
  -- vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<Space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<Space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
end


local servers = {
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
  hls = {},
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

-- local on_attach = function(client, bufnr)
--   lsp_status.on_attach(client)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec([[
--     hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--     hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--     hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--     augroup lsp_document_highlight
--     autocmd! * <buffer>
--     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--     augroup END
--     ]], false)
--   end
-- end


-- from cmp_nvim_lsp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }

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
vim.fn.sign_define(
  'DiagnosticSignError',
  {text = '', texthl = "DiagnosticDefaultError"}
)
vim.fn.sign_define(
  'DiagnosticSignWarn',
  {text = '', texthl = 'DiagnosticSignWarn'}
)
vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '', texthl = 'DiagnosticSignInfo' }
)
vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'DiagnosticSignHint' }
)
