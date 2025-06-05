return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  opts = function()
    require('copilot.api').status = require 'copilot.status'
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
