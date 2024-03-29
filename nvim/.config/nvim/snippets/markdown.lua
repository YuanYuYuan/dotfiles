local ls = require("luasnip")
local snp = ls.snippet
local ino = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local line_begin_cond = { condition = require("luasnip.extras.conditions.expand").line_begin }

local snippets = {}
local auto_snippets = {
  snp(
    "cbl",
    fmt(
      [[
     ```{}
     {}
     ```
    ]],
      { ino(1, "bash"), ino(2) }
    ),
    line_begin_cond
  ),
  snp("ilc", fmt("`{}`", { ino(1, "CODE") })),
  snp("img", fmt("![{}]({})", { ino(2, "NAME"), ino(1, "PATH") })),
  snp("lnk", fmt("[{}]({})", { ino(1, "NAME"), ino(2, "LINK") })),
  snp(
    "smm",
    fmt(
      [[
      <details>
      <summary>{}</summary>
      {}
      </details>
    ]],
      { ino(1, "Click Me"), ino(2) }
    ),
    line_begin_cond
  ),
}
return snippets, auto_snippets
