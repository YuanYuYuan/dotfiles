return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cmake",
          "comment",
          "cpp",
          -- "haskell",
          "hyprlang",
          "html",
          "javascript",
          "json",
          "json5",
          "just",
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
          disable = { "html" },
        },
        indent = { enable = true },
        autotag = { enable = true },
      })

      vim.filetype.add({
        pattern = {
          [".*/hypr/.*%.conf"] = "hyprlang",
          [".*/.*justfile"] = "just",
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
    },
  },
}
