return {
  "mhartington/formatter.nvim",
  cmd = { "Format", "FormatWrite" },
  config = function()
    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        c = { require("formatter.filetypes.c").clangformat },
        css = { require("formatter.filetypes.css").prettier },
        go = { require("formatter.filetypes.go").goimports },
        html = { require("formatter.filetypes.html").prettier },
        javascript = { require("formatter.filetypes.javascript").prettier },
        json = { require("formatter.filetypes.json").prettier },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettier },
        rust = { require("formatter.filetypes.rust").rustfmt },
        sh = { require("formatter.filetypes.sh").shfmt },
        toml = { require("formatter.filetypes.toml").taplo },
        typescript = { require("formatter.filetypes.typescript").prettier },
      },
    })
  end,
}
