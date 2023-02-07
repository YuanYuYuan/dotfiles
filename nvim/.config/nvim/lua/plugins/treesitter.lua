require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cmake",
    "comment",
    "cpp",
    "haskell",
    "html",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "toml",
    "yaml",
  },
  highlight = {
    enable = true,
  },
}
