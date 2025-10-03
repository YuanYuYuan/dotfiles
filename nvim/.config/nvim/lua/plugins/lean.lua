return {
  {
    "Julian/lean.nvim",
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    config = function()
      require("lean").setup()
    end,
  },
}
