require'bufferline'.setup{
  options = {
    diagnostics = "nvim_lsp",
    -- separator_style = "slant"
  }
}

local mappings = {
  ['<C-l>'] = 'BufferLineCycleNext',
  ['<C-h>'] = 'BufferLineCyclePrev',
  ['L'] = 'BufferLineMoveNext',
  ['H'] = 'BufferLineMovePrev',
}

for key, fcn in pairs(mappings) do
  vim.keymap.set('n', key, '<cmd>' .. fcn .. '<cr>', {noremap = true, silent = true})
end


local cmd = require('bufferline.commands')
for idx = 1, 9 do
  vim.keymap.set(
    'n',
    '<Space>' .. idx,
    function () cmd.go_to(idx) end,
    {noremap = true, silent = true}
  )
end
