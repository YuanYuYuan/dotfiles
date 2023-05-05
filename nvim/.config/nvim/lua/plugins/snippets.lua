return {
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  config = function()
    local ls = require "luasnip"
    local types = require "luasnip.util.types"

    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
    ls.config.set_config {
      history = true,
      -- Snippets aren't automatically removed if their text is deleted.
      -- `delete_check_events` determines on which events (:h events) a check for
      -- deleted snippets is performed.
      -- This can be especially useful when `history` is enabled.
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
      -- treesitter-hl has 100, use something higher (default is 200).
      ext_base_prio = 300,
      -- minimal increase in priority.
      ext_prio_increase = 1,
      enable_autosnippets = true,
      -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
      -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
      store_selection_keys = "<Tab>",
    }

    local utils = require("utils")
    utils.bind_mappings({
      ["<C-j>"] = {
        ["i,s"] = function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end
      },
      ["<C-k>"] = {
        ["i,s"] = function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end
      },
      ["<C-l>"] = {
        ["i,s"] = function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end
      },
      ["<C-h>"] = {
        ["i,s"] = function()
          if ls.choice_active() then
            ls.change_choice(-1)
          end
        end
      },
      ["<F4>"] = {
        ["i,n"] = function()
          require("luasnip.loaders").edit_snippet_files()
        end
      },
    })
  end,
}
