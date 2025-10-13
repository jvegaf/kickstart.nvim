return {
  'bassamsdata/namu.nvim',
  lazy = false,
  opts = {
    global = {},
    namu_symbols = { -- Specific Module options
      options = {},
    },
  },
  keys = {
    -- You can add keymaps here, or use the suggested ones below
    { '<leader>ss', ':Namu symbols<cr>', { desc = 'Jump to LSP symbol', silent = true } },
    { '<leader>sw', ':Namu workspace<cr>', { desc = 'LSP Symbols - Workspace', silent = true } },
  },
}
