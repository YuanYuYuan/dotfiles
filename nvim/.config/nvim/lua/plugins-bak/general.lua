-- maximize
require("maximize").setup({
  default_keymaps = true,
})
vim.keymap.set("n", "<space>z", "<Cmd>lua require('maximize').toggle()<CR>")
