return {
  'aaronik/treewalker.nvim',
  opts = {
    highlight = true,
    highlight_duration = 250,
    highlight_group = 'CursorLine',
  },
  keys = {
    { 'J', '<cmd>Treewalker Down<CR>', mode = { 'n', 'v' }, desc = 'Treewalker Down' },
    { 'K', '<cmd>Treewalker Up<CR>',   mode = { 'n', 'v' }, desc = 'Treewalker Up' },
  },
}
