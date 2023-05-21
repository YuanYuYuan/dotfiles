local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

-- require("config")
require("config.options")
require("config.keymappings")
-- require("config.fold")
if vim.fn.exists("g:neovide") > 0 then
  require("config.neovide")
end
require("config.autogroups")
-- vim.cmd("colorscheme nightfox")
