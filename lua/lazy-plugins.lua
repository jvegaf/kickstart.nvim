-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require('kickstart/plugins/anyjump'),
  -- require('kickstart/plugins/avante'),
  require('kickstart/plugins/mcp-hub'),
  require('kickstart/plugins/avante-mcphub'),
  -- require('kickstart/plugins/code-companion'),
  require('kickstart/plugins/copilot-old'),
  -- require('kickstart/plugins/copilot'),
  -- require 'kickstart/plugins/copilot-chat',
  require('kickstart/plugins/bufferline'),
  require('kickstart/plugins/blink-cmp'),
  require('kickstart/plugins/browser-search'),
  require('kickstart/plugins/conform'),
  require('kickstart/plugins/snacks'),
  require('kickstart/plugins/oklch-color'),
  require('kickstart/plugins/git'),
  require('kickstart/plugins/gitsigns'),
  require('kickstart/plugins/lspconfig'),
  require('kickstart/plugins/mini'),
  require('kickstart/plugins/nvim-ufo'),
  require('kickstart/plugins/pantran'),
  require('kickstart/plugins/platformio'),
  require('kickstart/plugins/toggleterm'),
  require('kickstart/plugins/lualine-nvim'),
  -- require 'kickstart/plugins/refactoring',
  require('kickstart/plugins/nvim-surround'),
  require('kickstart/plugins/telescope'),
  require('kickstart/plugins/tmux-navigator'),
  -- require 'kickstart/plugins/neo-tree',
  require('kickstart/plugins/nvim-tree'),
  require('kickstart/plugins/todo-comments'),
  require('kickstart/plugins/tokyonight'),
  require('kickstart/plugins/treesitter'),
  require('kickstart/plugins/treesj'),
  require('kickstart/plugins/treewalker'),
  -- require('kickstart/plugins/undo'),
  require('kickstart/plugins/url-open'),
  require('kickstart/plugins/vim-easy-align'),
  require('kickstart/plugins/vim-visual-multi'),
  require('kickstart/plugins/which-key'),

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
