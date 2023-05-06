local ls = require("luasnip")
local snp = ls.snippet
local ino = ls.insert_node
local sno = ls.snippet_node
-- local fno = ls.function_node
local tno = ls.text_node
local cno = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep
local line_begin_cond = { condition = require("luasnip.extras.conditions.expand").line_begin }

local snippets = {}
local auto_snippets = {

  -- for loop
  snp(
    "fo ",
    fmt(
      [[
        for ({cond}) {{
            {todo}
        }}
      ]],
      {
        cond = cno(1, {
          -- for (int i = 0; i < N; i++)
          sno(
            2,
            fmt("int {} = {}; {} < {}; {}++", {
              ino(1, "i"),
              ino(2, "0"),
              rep(1),
              ino(3, "N"),
              rep(1),
            })
          ),

          -- for (auto v: vec)
          sno(
            1,
            fmt("auto {}: {}", {
              ino(1, "v"),
              ino(2, "vec"),
            })
          ),
        }),
        todo = ino(2),
      }
    ),
    line_begin_cond
  ),

  -- -- include
  -- snp(
  --   "in ",
  --   {
  --     tno("#include <"),
  --     ino(1, "vector"),
  --     fno(function(arg, _)
  --       if arg[1][1] == "" then  return "" end
  --       return string.sub(arg[1][1], -1) == ">" and "" or ">"
  --     end, 1)
  --   },
  --   line_begin_cond
  -- ),

  -- std namespace
  snp("un ", tno("using namespace std;"), line_begin_cond),

  -- cout
  snp("co ", {
    tno("cout << "),
    ino(1, "str"),
    tno(" << "),
    cno(2, { tno("endl;"), ino(1, "str") }),
  }, line_begin_cond),

  -- main
  snp(
    "ma ",
    fmt(
      [[
        int main() {{
            {}
            return 0;
        }}
      ]],
      ino(1)
    ),
    line_begin_cond
  ),

  -- vector<T>
  snp("v<", fmt("vector<{}>", { ino(1, "int") })),

  -- if
  snp("if ", fmt("if ({})", { ino(1) })),

  -- while
  snp("wh ", fmt("while ({})", { ino(1) }), line_begin_cond),

  -- sort
  snp("so ", fmt("sort({}.begin(), {}.end());", { ino(1), rep(1) }), line_begin_cond),
}

return snippets, auto_snippets
