return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },

    config = function()
      local utils = require("utils")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          scroll_strategy = "limit",
          layout_config = {
            horizontal = { preview_width = 0.6 },
          },
          path_display = { "smart" },
          -- wrap_results = true,
          mappings = {
            i = {
              ["<C-j>"] = actions.preview_scrolling_down,
              ["<C-k>"] = actions.preview_scrolling_up,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
            },
            n = {
              ["J"] = actions.preview_scrolling_down,
              ["K"] = actions.preview_scrolling_up,
              ["q"] = actions.close,
            },
          },
          vimgrep_arguments = {
            "rg",

            -- these four are required
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",

            "--smart-case",
            "--fixed-strings", -- disable regex
          },
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
      })

      require("telescope").load_extension("undo")

      -- https://github.com/nvim-telescope/telescope.nvim/issues/592
      local my_live_grep = function(opts)
        opts = opts or {}
        opts.path_display = { "absolute" }
        -- opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if vim.v.shell_error ~= 0 then
          -- if not git then active lsp client root
          -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
          local active_clients = vim.lsp.get_active_clients()
          if next(active_clients) == nil then
            opts.cwd = nil
          else
            opts.cwd = active_clients[1].config.root_dir
          end
        end
        require("telescope.builtin").live_grep(opts)
      end

      utils.bind_mappings({
        -- ['<Space>f'] = builtin.oldfiles,
        ["gd"] = builtin.lsp_definitions,
        ["gi"] = builtin.lsp_implementations,
        ["gr"] = builtin.lsp_references,
        ["<Space>go"] = builtin.oldfiles,
        -- ['<Space>gf'] = builtin.find_files,
        ["<Space>gg"] = builtin.git_files,
        ["<Space>gh"] = builtin.help_tags,
        ["<Space>gb"] = builtin.buffers,
        ["?"] = {
          v = function()
            my_live_grep({ default_text = utils.get_visual_selection() })
          end,
          n = my_live_grep,
        },
        -- lsp related
        ["K"] = vim.lsp.buf.hover,
        ["[e"] = vim.diagnostic.goto_prev,
        ["]e"] = vim.diagnostic.goto_next,
        ["<Space><Space>e"] = vim.diagnostic.setloclist,
        ["<Space><Space>d"] = builtin.diagnostics,
        ["<Space><Space>c"] = vim.lsp.buf.code_action,
        ["<Space><Space>w"] = { ["n,v"] = vim.lsp.buf.format },
      })

      local command_mode_extension = function()
        local mode = vim.fn.getcmdtype()
        if mode == ":" then
          require("telescope.builtin").command_history()
        elseif mode == "/" then
          require("telescope.builtin").search_history()
        else
          return "<C-f>"
        end
      end

      vim.keymap.set({ "c" }, "<C-f>", command_mode_extension)
    end,
  },
}
