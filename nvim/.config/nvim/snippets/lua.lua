local ls = require('luasnip')
local snp = ls.snippet
local ino = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {}
local auto_snippets = {
  snp("lf ",
    fmt([[
      local {} = function()
        {}
      end
    ]], {ino(1, "fcn"), ino(2)})
  )
}
return snippets, auto_snippets
