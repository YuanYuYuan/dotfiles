return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        -- direction = 'vertical',
        direction = "horizontal",
        float_opts = {
          border = "curved",
        },
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      })

      vim.keymap.set({ "t" }, "<Esc>", "<C-\\><C-n>")

      local speak_and_trans = function(text, lang)
        lang = lang or "en-US"
        local prev_win = vim.api.nvim_get_current_win()
        local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
        require("toggleterm").exec(string.format('trans -b -speak -s %s -t zh-TW "%s"', lang, text))
        vim.api.nvim_win_set_cursor(prev_win, prev_pos)
        vim.api.nvim_set_current_win(prev_win)
      end

      -- speak & translate selection
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "text",
        callback = function()
          local key_lang_map = {
            ["<F3>"] = "en-US",
            ["<Space>3"] = "en-US",
            ["<F4>"] = "fr",
            ["<Space>4"] = "fr",
          }
          for key, lang in pairs(key_lang_map) do
            vim.keymap.set({ "v" }, key, function()
              speak_and_trans(require("utils").get_visual_selection(), lang)
            end)
            vim.keymap.set({ "n" }, key, function()
              speak_and_trans(vim.api.nvim_get_current_line(), lang)
            end)
          end
        end,
      })

      -- python send visual selection
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "python",
        callback = function()
          vim.keymap.set({ "v" }, "<F3>", ":ToggleTermSendVisualSelection<CR>")
          vim.keymap.set({ "v" }, "<Space>3", ":ToggleTermSendVisualSelection<CR>")
        end,
      })
    end,
  },
}
