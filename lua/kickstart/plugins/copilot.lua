return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  lazy = false,
  opts = function()
    require('copilot').setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })

    require('copilot.api').status = require('copilot.status')
    require('copilot.api').filetypes = {
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
    }
  end,
}
