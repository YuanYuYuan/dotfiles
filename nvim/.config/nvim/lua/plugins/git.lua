return {
  -- pwntester/octo.nvim
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        suppress_missing_scope = {
          projects_v2 = true,
        }
      })
      vim.treesitter.language.register("markdown", "octo")
    end,
  },

  -- sindrets/diffview.nvim
  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          view = {
            { "n", "<Space>ch", actions.conflict_choose("ours") },
            { "n", "<Space>cl", actions.conflict_choose("theirs") },
            { "n", "<Space>cn", actions.next_conflict },
            { "n", "<Space>cp", actions.prev_conflict },
            { "n", "<Space>cb", actions.toggle_files },
            { "n", "<Space>cx", actions.cycle_layout },
          },
        },
      })
    end,
  },

  -- tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
    config = function()
      require("utils").bind_mappings({
        ["<Space>gv"] = "<Cmd>Gvdiffsplit<CR>",
        ["<Space>gb"] = "<Cmd>G Blame<CR>",
      })
    end,
  },

  -- linrongbin16/gitlinker.nvim
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    config = function()
      require('gitlinker').setup({})
    end,
  },

  -- lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gs.nav_hunk('next')
            end
          end)
          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gs.nav_hunk('prev')
            end
          end)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

          map('n', 'gss', gs.stage_hunk)
          map('n', 'gsr', gs.reset_hunk)
          map('n', 'gsu', gs.undo_stage_hunk)
          map('n', 'gsp', gs.preview_hunk)
          map('n', 'gsd', gs.diffthis)
        end
      })
    end,
  },

 {
  "NeogitOrg/neogit",
  config = function()
    require("neogit").setup()
  end
  },
}
