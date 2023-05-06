local ls = require("luasnip")
local snp = ls.snippet
local tno = ls.text_node
local line_begin_cond = { condition = require("luasnip.extras.conditions.expand").line_begin }

local snippets = {}
local auto_snippets = {
  snp("shb", tno("#!/usr/bin/env bash"), line_begin_cond),
}
return snippets, auto_snippets
