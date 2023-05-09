return {
  {
    "EdenEast/nightfox.nvim",
    -- Load it during startup
    lazy = false,
    -- Load this before all the other plugins
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "bold",
          },
        },
        groups = {
          all = {
            Folded = { bg = "none" },
            Comment = { fg = "#33cccc" },
            Visual = { bg = "#01779c" },
          },
        },
      })
      vim.cmd("colorscheme nightfox")
    end,
  },
}
