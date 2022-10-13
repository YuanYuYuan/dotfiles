local ls = require("luasnip")
local snp = ls.snippet
local ino = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local line_begin_cond = { condition = require("luasnip.extras.conditions.expand").line_begin }

local snippets = {}
local auto_snippets = {
  snp("cbl",
    fmt([[
     ```{}
     {}
     ```
    ]], {ino(1, "bash"), ino(2)}),
    line_begin_cond
  ),
}
return snippets, auto_snippets