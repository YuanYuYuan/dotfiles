return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          view = {
            { "n", "<Space>ch",  actions.conflict_choose("ours") },
            { "n", "<Space>cl",  actions.conflict_choose("theirs") },
            { "n", "<Space>cn",  actions.next_conflict },
            { "n", "<Space>cp",  actions.prev_conflict },
            { "n", "<Space>cb",  actions.toggle_files },
            { "n", "<Space>cx",  actions.cycle_layout },
          }
        }
      })
    end
  },
  {
    "tpope/vim-fugitive",
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
