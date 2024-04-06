local utils = require("utils")

local augroup = function(group_name)
  return vim.api.nvim_create_augroup(group_name, { clear = true })
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    "toml",
    "haskell",
    "lua",
    "yaml",
    "json",
    "json5",
    "html",
    "tex",
    "markdown",
  },
  group = augroup("ShorterSpaceAuGroup"),
  callback = function()
    for _, opt in ipairs({ "tabstop", "softtabstop", "shiftwidth" }) do
      vim.opt[opt] = 2
    end
  end,
})

local toggle_term = function(cmd)
  local prev_win = vim.api.nvim_get_current_win()
  local prev_pos = vim.api.nvim_win_get_cursor(prev_win)
  require("toggleterm").exec(cmd(vim.fn.expand("%")))
  vim.api.nvim_win_set_cursor(prev_win, prev_pos)
  vim.api.nvim_set_current_win(prev_win)
end

local cmd_table_collection = {
  vim_cmd_table = utils
    .Table({
      markdown = "MarkdownPreview",
      lua = "luafile %",
      tex = "VimtexCompile",
      json5 = "!json5 -v %",
    })
    :map(function(cmd)
      return function()
        vim.cmd("write")
        vim.cmd(cmd)
      end
    end),

  toggleterm_cmd_table = utils
    .Table({
      c = function(file)
        local exe = file:gsub(".c", ".out")
        return string.format("gcc %s -o %s && ./%s", file, exe, exe)
      end,
      cpp = function(file)
        local exe = file:gsub(".cpp", ".out")
        return string.format("g++ %s -o %s && ./%s", file, exe, exe)
      end,
      python = function(file)
        return "python " .. file
      end,
      sh = function(file)
        return "bash " .. file
      end,
    })
    :map(function(cmd)
      return function()
        vim.cmd("write")
        toggle_term(cmd)
      end
    end),
}

local cmd_table = {}
local filetypes = {}
for _, tbl in pairs(cmd_table_collection) do
  for ft, cmd in pairs(tbl) do
    cmd_table[ft] = cmd
    filetypes[#filetypes + 1] = ft
  end
end

-- F3AuGroup for insert & normal mode
vim.api.nvim_create_autocmd("Filetype", {
  pattern = filetypes,
  group = augroup("F3AuGroup"),
  callback = function()
    vim.keymap.set({ "i", "n" }, "<F3>", function()
      cmd_table[vim.bo.filetype]()
    end)
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = filetypes,
  group = augroup("Space3AuGroup"),
  callback = function()
    vim.keymap.set({ "n" }, "<Space>3", function()
      cmd_table[vim.bo.filetype]()
    end)
  end,
})

-- Jump to the last position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})
