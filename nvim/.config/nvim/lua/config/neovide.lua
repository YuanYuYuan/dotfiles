-- adjust color
-- vim.cmd('highlight CursorLine guibg=#1B2229')

-- font size & font list
local font_size = 10
local font_list = {
  "FiraCode Nerd Font",
  "Font Awesome 5 Free",
  "DejaVuSans",
  "Noto Color Emoji",
}

-- setup font list
local fonts = ""
for _, str in ipairs(font_list) do
  if fonts == "" then
    fonts = str
  else
    fonts = fonts .. "," .. str
  end
end

local set_font = function(fsize)
  vim.opt.guifont = fonts .. ":h" .. tostring(fsize)
end

local change_size = function(change)
  return function()
    font_size = font_size + change
    vim.opt.guifont = fonts .. ":h" .. tostring(font_size)
  end
end

set_font(font_size)
vim.keymap.set("n", "<C-=>", change_size(1))
vim.keymap.set("n", "<C-->", change_size(-1))
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- transparency
vim.opt["background"] = "dark"
vim.g.neovide_transparency = 0.7
