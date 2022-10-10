local ls = require('luasnip')
local s = ls.snippet
local tn = ls.text_node

local snippets = {}
local auto_snippets = {}

local first = s('test', {tn('This is my first test')})

table.insert(snippets, first)

return snippets, auto_snippets

