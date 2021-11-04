-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/circle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/circle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/circle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/circle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/circle/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/asyncrun.vim"
  },
  ["auto-pairs"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["emmet-vim"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["galaxyline.nvim"] = {
    config = { "require'plugins.statusline'" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2‰\1\0\0\2\0\6\0\n4\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0014\0\3\0007\0\4\0%\1\5\0>\0\2\1G\0\1\0?        nnoremap <Space>gb :Gitsigns blame_line<CR>\n      \bcmd\bvim\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    config = { "require'plugins.lsp'" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/circle/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  mru = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/mru"
  },
  nerdcommenter = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-bufferline.lua"] = {
    config = { "require'plugins.bufferline'" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require 'colorizer'.setup()" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\2v\0\0\2\0\5\0\b4\0\0\0%\1\1\0>\0\2\0014\0\2\0007\0\3\0%\1\4\0>\0\2\1G\0\1\0005        set completeopt+=menuone,noselect\n      \bcmd\bvim\18plugins.compe\frequire\0" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2Ë\2\0\0\4\0\15\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\6\0003\2\3\0003\3\4\0:\3\5\2:\2\a\0013\2\b\0:\2\t\0013\2\n\0:\2\v\1>\0\2\0014\0\f\0007\0\r\0%\1\14\0>\0\2\1G\0\1\0005        nnoremap <F1> :NvimTreeToggle<CR>\n      \bcmd\bvim\tview\1\0\3\16auto_resize\2\tside\tleft\21hide_root_folder\1\24update_focused_file\1\0\2\15update_cwd\2\venable\2\16diagnostics\1\0\0\nicons\1\0\4\tinfo\bïš\thint\bïª\nerror\bï—\fwarning\bï±\1\0\1\venable\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require'plugins.treesitter'" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\1\2¢\1\0\0\2\0\5\0\b4\0\0\0%\1\1\0>\0\2\0014\0\2\0007\0\3\0%\1\4\0>\0\2\1G\0\1\0b        nnoremap <F3> :RustRunnables<CR>\n        inoremap <F3> <Esc>:RustRunnables<CR>\n      \bcmd\bvim\17plugins.rust\frequire\0" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/switch.vim"
  },
  tabular = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-argwrap"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-argwrap"
  },
  ["vim-asciidoctor"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-asciidoctor"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-cursorword"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-cursorword"
  },
  ["vim-surround"] = {
    config = { "" },
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  vimtex = {
    config = { "" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/circle/.local/share/nvim/site/pack/packer/opt/vimtex"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["zephyr-nvim"] = {
    loaded = true,
    path = "/home/circle/.local/share/nvim/site/pack/packer/start/zephyr-nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require'plugins.treesitter'
time([[Config for nvim-treesitter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)

time([[Config for indent-blankline.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\1\2¢\1\0\0\2\0\5\0\b4\0\0\0%\1\1\0>\0\2\0014\0\2\0007\0\3\0%\1\4\0>\0\2\1G\0\1\0b        nnoremap <F3> :RustRunnables<CR>\n        inoremap <F3> <Esc>:RustRunnables<CR>\n      \bcmd\bvim\17plugins.rust\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: vim-asciidoctor
time([[Config for vim-asciidoctor]], true)

time([[Config for vim-asciidoctor]], false)
-- Config for: tabular
time([[Config for tabular]], true)

time([[Config for tabular]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
require'plugins.bufferline'
time([[Config for nvim-bufferline.lua]], false)
-- Config for: mru
time([[Config for mru]], true)

time([[Config for mru]], false)
-- Config for: emmet-vim
time([[Config for emmet-vim]], true)

time([[Config for emmet-vim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2Ë\2\0\0\4\0\15\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\6\0003\2\3\0003\3\4\0:\3\5\2:\2\a\0013\2\b\0:\2\t\0013\2\n\0:\2\v\1>\0\2\0014\0\f\0007\0\r\0%\1\14\0>\0\2\1G\0\1\0005        nnoremap <F1> :NvimTreeToggle<CR>\n      \bcmd\bvim\tview\1\0\3\16auto_resize\2\tside\tleft\21hide_root_folder\1\24update_focused_file\1\0\2\15update_cwd\2\venable\2\16diagnostics\1\0\0\nicons\1\0\4\tinfo\bïš\thint\bïª\nerror\bï—\fwarning\bï±\1\0\1\venable\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nerdcommenter
time([[Config for nerdcommenter]], true)

time([[Config for nerdcommenter]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\1\2v\0\0\2\0\5\0\b4\0\0\0%\1\1\0>\0\2\0014\0\2\0007\0\3\0%\1\4\0>\0\2\1G\0\1\0005        set completeopt+=menuone,noselect\n      \bcmd\bvim\18plugins.compe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)

time([[Config for nvim-lspconfig]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)

time([[Config for ultisnips]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
require'plugins.statusline'
time([[Config for galaxyline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2‰\1\0\0\2\0\6\0\n4\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0014\0\3\0007\0\4\0%\1\5\0>\0\2\1G\0\1\0?        nnoremap <Space>gb :Gitsigns blame_line<CR>\n      \bcmd\bvim\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: vim-argwrap
time([[Config for vim-argwrap]], true)

time([[Config for vim-argwrap]], false)
-- Config for: vim-surround
time([[Config for vim-surround]], true)

time([[Config for vim-surround]], false)
-- Config for: auto-pairs
time([[Config for auto-pairs]], true)

time([[Config for auto-pairs]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require 'colorizer'.setup()
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lsp-status.nvim
time([[Config for lsp-status.nvim]], true)
require'plugins.lsp'
time([[Config for lsp-status.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/circle/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
