return {
  "junegunn/vim-easy-align",
  event = "BufReadPre",
  keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign" } },
}
