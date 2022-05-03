-- Setup global options
local global_options = {
	showcmd = true,
	history = 10000,
	clipboard = 'unnamedplus',
	autochdir = true,
	timeoutlen = 400, -- shorter timeout for key combinations
	showmatch = true,
	previewheight = 5, -- height of completion preview
	pumheight = 10, -- height of pop-up menu
	updatetime = 300,
}

for key, val in pairs(global_options) do
	vim.api.nvim_set_option(key, val)
end

local window_options = {
	number = true,
	relativenumber = true,
	cursorline = true,
}

for key, val in pairs(window_options) do
	vim.api.nvim_win_set_option(0, key, val)
end

