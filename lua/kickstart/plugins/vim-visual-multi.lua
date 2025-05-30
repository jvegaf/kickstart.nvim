return {
  "mg979/vim-visual-multi",
  keys = {
    "<C-n>",
    "<C-Up>",
    "<C-Down>",
    "<S-Up>",
    "<S-Down>",
    "<S-Left>",
    "<S-Right>",
  },
  config = function()
    vim.g.VM_leader = ";"
  end,
}
