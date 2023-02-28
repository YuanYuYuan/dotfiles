
-- -- TODO: folding, check this
-- vim.cmd([[
--   augroup MyStart
--     au!
--     au BufEnter,CursorHold * checktime
--     au BufWinEnter * normal! zR
--   augroup END
-- ]])
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- function _G.my_custom_folding()
--   return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
-- end


function _G.my_fold_text()
  local head = vim.fn.getline(vim.v.foldstart):gsub('{{{', '')
  -- head = head:gsub('%s+', '')
  local tail = vim.fn.getline(vim.v.foldend):gsub('.*}}}', '')
  tail = tail:gsub('^%s*', '')
  local text = head
  if tail ~= "" then
    text = text .. ' … ' .. tail
  end

  if vim.bo.filetype == "python" then
    -- class or function
    if string.find(text, ":") then
      text = string.match(text, "(.*:)")
    end
  end

  return text
end

vim.opt.fillchars:append({fold = ' '})
vim.opt.foldtext = 'v:lua.my_fold_text()'
vim.opt.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'


-- vim.api.nvim_create_autocmd('Filetype', {
--   pattern = {'cpp', 'rust'},
--   callback = function()
--     vim.opt.foldmethod = 'syntax'
--     vim.opt.syntax = 'cpp'
--   end
-- })

local toggle_folding = function()
  local win_set = vim.api.nvim_win_set_option
  if vim.api.nvim_buf_line_count(0) > 10000 then
    win_set(0, 'foldenable', false)
    win_set(0, 'foldmethod', 'manual')
  else
    win_set(0, 'foldenable', true)
    win_set(0, 'foldmethod', 'syntax')
  end
end
local disable_fold_augroup = vim.api.nvim_create_augroup(
  'DisableFoldForLargeFile',
  {clear = true}
)
vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'json', 'json5'},
  group = disable_fold_augroup,
  callback = toggle_folding,
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = {'zsh', 'tmux'},
  callback = function ()
    local win_set = vim.api.nvim_win_set_option
    win_set(0, 'foldmethod', 'marker')
    win_set(0, 'foldmarker', '{{{,# }}}')
  end,
})

vim.keymap.set({'n'}, '<Tab>', 'zazz', { noremap = true })
