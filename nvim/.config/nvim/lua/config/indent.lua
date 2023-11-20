-- https://www.reddit.com/r/neovim/comments/17aponn/comment/k5f2n7t/?utm_source=share&utm_medium=web2x&context=3
vim.opt.list = true
vim.opt.listchars = {
  tab = "⇥ ",
  trail = "+",
  precedes = "<",
  extends = ">",
  space = "·",
  nbsp = "␣",
  leadmultispace = "┊ ",
}
local function update_lead()
  local lead = "┊"
  for _ = 1, vim.bo.shiftwidth - 1 do
    lead = lead .. " "
  end
  vim.opt_local.listchars:append({ leadmultispace = lead })
end
vim.api.nvim_create_autocmd("OptionSet", { pattern = { "listchars", "tabstop", "filetype" }, callback = update_lead })
vim.api.nvim_create_autocmd("VimEnter", { callback = update_lead, once = true })
