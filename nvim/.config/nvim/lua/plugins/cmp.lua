local cmp = require('cmp')
local lspkind = require('lspkind')
local symbols = require('plugins.symbols')
lspkind.init {symbol_map = symbols.kind_labels}

vim.opt.completeopt = 'menuone,noselect'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- nvim-cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      -- vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind

      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        buffer = '[Buffer]',
        nvim_lua = '[Lua]',
      })[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping(
      function(fallback)
        if vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<C-j>'] = cmp.mapping(
      function(fallback)
        if vim.fn['vsnip#jumpable'](1) == 1 then
          feedkey('<Plug>(vsnip-jump-next)', '')
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<C-k>'] = cmp.mapping(
      function(fallback)
        if vim.fn['vsnip#jumpable'](1) == 1 then
          feedkey('<Plug>(vsnip-jump-prev)', '')
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<C-c>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- ["<CR>"] = cmp.mapping(
    --   function(fallback)
    --     if cmp.visible() and has_words_before() then
    --       cmp.mapping.confirm {
    --         behavior = cmp.ConfirmBehavior.Replace,
    --         select = true,
    --       }
    --     else
    --       fallback()
    --     end
    --   end,
    --   { "i", "s" }
    -- ),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      {'i', 's'}
    ),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    {'i', 's'}
    ),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'vsnip' },
    { name = 'cmp_tabnine' },
    -- { name = 'emoji' }
  },
}
