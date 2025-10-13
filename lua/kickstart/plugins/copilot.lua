return {
  {
    'zbirenbaum/copilot.lua',
    lazy = false,
    priority = 1000,
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
}
