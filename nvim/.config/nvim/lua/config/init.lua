require 'config.options'
require 'config.keymappings'
require 'config.fold'
if vim.fn.exists('g:neovide') > 0 then
	require 'config.neovide'
end
require 'config.autogroups'
