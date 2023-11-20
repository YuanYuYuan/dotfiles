local option_collection = {
  basics = {
    showcmd = true,
    history = 10000,
    cursorline = true,
    autochdir = true,
    mouse = "a",
    hidden = true,
    clipboard = "unnamedplus",
    timeoutlen = 400, -- shorter timeout for key combinations

    -- line number
    number = true,
    relativenumber = true,

    showmatch = true, -- highlight matching brackets
    previewheight = 5, -- height of completion preview
    pumheight = 10, -- height of pop-up menu
    updatetime = 300,
    smarttab = true, -- use shiftwidth instead of tabstop at start of lines

    -- ignore case
    ignorecase = true, -- ignore case during search
    smartcase = true, -- ignore case if searching pattern is all lowercase
    wildignorecase = true, -- ignore case when doing completion

    -- indent
    autoindent = true, -- Copy indent from current line when starting a new line
    smartindent = true, -- Do smart autoindenting when starting a new line.

    -- conceal
    conceallevel = 2,

    shada = "!,'1000,<50,s10,h"
  },

  tab_and_space = {
    expandtab = true, -- expand tab to spaces
    tabstop = 4, -- set tab to 4-spaces-wide
    softtabstop = 4, -- set tab to 4-spaces-wide when editing
    shiftwidth = 4, -- < and > will shift 4 spaces
  },

  split = {
    splitbelow = true,
    splitright = true,
  },
}

for _, options in pairs(option_collection) do
  for key, val in pairs(options) do
    vim.opt[key] = val
  end
end
