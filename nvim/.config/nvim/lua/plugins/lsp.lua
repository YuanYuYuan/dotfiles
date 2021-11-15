local lsp_config = require('lspconfig')
local lsp_status = require('lsp-status')
local lsp_kind = require('lspkind')
local saga = require('lspsaga')
local lsp = vim.lsp
local cmd = vim.cmd
local buf_keymap = vim.api.nvim_buf_set_keymap
local map = vim.api.nvim_set_keymap
local kind_symbols = {
  Text        = '韛',
  Function    = '',
  Method      = ' ',
  Constructor = ' ',
  Variable    = '凜',
  Class       = '﬿ ',
  Interface   = '擄',
  Module      = '璉',
  Property    = 'ﯟ ',
  Unit        = ' ',
  Value       = '藍',
  Enum        = ' ',
  Keyword     = ' ',
  Snippet     = ' ',
  Color       = ' ',
  File        = ' ',
  Folder      = ' ',
  EnumMember  = ' ',
  Constant    = ' ',
  Struct      = ' ',
  Field       = ' ',
}

-- vim.fn.sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
-- vim.fn.sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
-- vim.fn.sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
-- vim.fn.sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})



lsp_status.config {
  kind_labels = kind_symbols,
  diagnostics = false,
  status_symbol = "",
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
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  -- virtual_text = {
  --   prefix = "»",
  --   spacing = 4,
  -- },
  signs = true,
  update_in_insert = false,
  underline = true
})

saga.init_lsp_saga {use_saga_diagnostic_sign = true}

map('n', '<F2>', '<cmd>LspStart<CR>', {noremap = true})
map('i', '<F2>', '<cmd>LspStart<CR>', {noremap = true})


local keymap_opts = {noremap = true, silent = true}
local function on_attach(client)
  lsp_status.on_attach(client)
  buf_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymap_opts)
  buf_keymap(0, 'n', '<Space>sd', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', keymap_opts)
  -- buf_keymap(0, 'n', 'gS', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', keymap_opts)
  buf_keymap(0, 'n', '<leader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gh', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', keymap_opts)
  buf_keymap(0, 'n', 'gA', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', keymap_opts)
  buf_keymap(0, 'v', 'gA', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', keymap_opts)
  buf_keymap(0, 'n', ']e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>', keymap_opts)
  buf_keymap(0, 'n', '[e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>', keymap_opts)
  cmd('au CursorHold <buffer> lua require("lspsaga.diagnostic").show_cursor_diagnostics()')
  -- cmd('au CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.resolved_capabilities.document_formatting then
    buf_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', keymap_opts)
  end

  if client.resolved_capabilities.document_highlight == true then
    cmd('augroup lsp_aucmds')
    cmd('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
    -- cmd('au CursorHold <buffer> lua require("lspsaga.diagnostic").show_cursor_diagnostics()')
    -- cmd('au CursorHold <buffer> lua require("lspsaga.diagnostic").show_line_diagnostics()')
    cmd('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
    cmd('augroup END')
  end
end

-- lsp_config.rust_analyzer.setup({
--     cmd = { "rust-analyzer" },
--     -- filetypes = { "rust" },
--     root_dir = lsp_config.util.root_pattern("Cargo.toml"),
--     settings = {
--         ["rust-analyzer"] = {}
--     },
--     on_attach = lsp_status.on_attach,
--     capabilities = lsp_status.capabilities
-- })


local servers = {
  sqls = {},
  gopls = {},
  pyright = {},
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
  julials = {}
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


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

for server, config in pairs(servers) do
  -- config.autostart = false
  config.on_attach = on_attach
  -- config.capabilities = lsp_status.capabilities
  config.capabilities = capabilities
  -- config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {},
  -- lsp_status.capabilities, snippet_capabilities)
  lsp_config[server].setup(config)
end


vim.fn.sign_define(
  'LspDiagnosticsSignError',
  {text = "", texthl = "LspDiagnosticsDefaultError"}
)
vim.fn.sign_define(
  'LspDiagnosticsSignWarning',
  {text = "", texthl = "LspDiagnosticsDefaultWarning"}
)
vim.fn.sign_define(
  'LspDiagnosticsSignInformation',
  { text = "", texthl = "LspDiagnosticsDefaultInformation" }
)
vim.fn.sign_define(
  'LspDiagnosticsSignHint',
  { text = "", texthl = "LspDiagnosticsDefaultHint" }
)

return on_attach
