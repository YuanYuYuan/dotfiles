return {
  {
    "nvim-telescope/telescope.nvim",
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
          path_display = { truncate = 4 },
          -- path_display = { "smart" },
          -- wrap_results = true,
          mappings = {
            i = {
              ["<C-j>"] = actions.preview_scrolling_down,
              ["<C-k>"] = actions.preview_scrolling_up,
              ["<C-h>"] = actions.results_scrolling_left,
              ["<C-l>"] = actions.results_scrolling_right,
              ["<Tab>"] = actions.move_selection_next,
              ["<S-Tab>"] = actions.move_selection_previous,
            },
            n = {
              ["J"] = actions.preview_scrolling_down,
              ["K"] = actions.preview_scrolling_up,
              ["H"] = actions.results_scrolling_left,
              ["L"] = actions.results_scrolling_right,
              ["q"] = actions.close,
              ["o"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Space>"] = actions.toggle_selection,
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
          find_files = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          live_grep = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          lsp_implementations = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          lsp_definitions = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          lsp_references = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          oldfiles = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          git_files = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          help_tags = { theme = "ivy", layout_config = { height = 0.4, preview_width = 0.5 } },
          buffers = {
            theme = "ivy",
            layout_config = { height = 0.4, preview_width = 0.5 },
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["<c-d>"] = "delete_buffer",
                ["o"] = "file_edit",
                ["`"] = "file_edit",
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
        opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
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
        opts.initial_mode = "normal"
        require("telescope.builtin").live_grep(opts)
      end

      utils.bind_mappings({
        -- ['<Space>f'] = builtin.oldfiles,
        ["gd"] = builtin.lsp_definitions,
        ["gi"] = builtin.lsp_implementations,
        ["gr"] = builtin.lsp_references,
        ["<Space><Space>o"] = builtin.oldfiles,
        -- ['<Space>gf'] = builtin.find_files,
        ["<Space><Space>g"] = builtin.git_files,
        ["<Space>th"] = builtin.help_tags,
        -- ["<Space><Space>b"] = builtin.buffers,
        ["<Space>`"] = function ()
          require("telescope.builtin").buffers({ initial_mode = "normal" })
        end,
        ["?"] = {
          v = function()
            my_live_grep({ default_text = utils.get_visual_selection() })
          end,
          n = my_live_grep,
        },
        -- lsp related
        ["<Space><Space>e"] = vim.diagnostic.setloclist,
        ["<Space>d"] = function() builtin.diagnostics({ sort_by = "severity", initial_mode = "normal" }) end,

        -- NOTE: Use the new default mappings
        -- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
        -- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
        -- "grr" is mapped in Normal mode to vim.lsp.buf.references()
        -- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
        -- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
        -- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
        --
        -- -- Deprecated
        -- ["K"] = vim.lsp.buf.hover,
        -- ["<Space><Space>c"] = vim.lsp.buf.code_action,
        -- ["[d"] = vim.diagnostic.goto_prev,
        -- ["]d"] = vim.diagnostic.goto_next,

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
