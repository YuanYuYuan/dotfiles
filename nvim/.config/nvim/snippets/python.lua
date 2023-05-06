local ls = require("luasnip")
local snp = ls.snippet
local tno = ls.text_node
local ino = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local line_begin_cond = { condition = require("luasnip.extras.conditions.expand").line_begin }

local snippets = {}
local auto_snippets = {
  snp("shb", tno("#!/usr/bin/env python3"), line_begin_cond),
  snp("ipdb", tno("import ipdb; ipdb.set_trace()"), line_begin_cond),
  snp("imnp", tno("import numpy as np"), line_begin_cond),
  snp("impd", tno("import pandas as pd"), line_begin_cond),
  snp("impt", tno("import matplotlib.pyplot as plt"), line_begin_cond),
  snp(
    "imap",
    fmt(
      [[
      import argparse
      
      parser = argparse.ArgumentParser()
      parser.add_argument({})
      args = parser.parse_args()
    ]],
      ino(1)
    ),
    line_begin_cond
  ),
}
return snippets, auto_snippets
