return {
  {
    "tpope/vim-fugitive" ,
    config = function()
      require("utils").bind_mappings({
        ["<Space>gv"] = "<Cmd>Gvdiffsplit<CR>",
        ["<Space>gb"] = "<Cmd>G Blame<CR>",
      })
    end

  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_auto_close = 0
    end,
  },
}
