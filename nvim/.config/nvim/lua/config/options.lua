local option_collection = {
    global_options = {
        showcmd = true,
        history = 10000,
        clipboard = 'unnamedplus',
        autochdir = true,
        timeoutlen = 400, -- shorter timeout for key combinations
        showmatch = true,
        previewheight = 5, -- height of completion preview
        pumheight = 10, -- height of pop-up menu
        updatetime = 300,
        smarttab = true, -- use shiftwidth instead of tabstop at start of lines
    },
    window_options = {
        number = true,
        relativenumber = true,
        cursorline = true,
    },
    buffer_options = {
        expandtab = true, -- expand tab to spaces
        tabstop = 4, -- set tab to 4-spaces-wide
        softtabstop = 4, -- set tab to 4-spaces-wide when editing
        shiftwidth = 4, -- < and > will shift 4 spaces

        autoindent = true, -- Copy indent from current line when starting a new line
        smartindent = true, -- Do smart autoindenting when starting a new line.
    }
}

for _, options in pairs(option_collection) do
    for key, val in pairs(options) do
        vim.opt[key] = val
    end
end
