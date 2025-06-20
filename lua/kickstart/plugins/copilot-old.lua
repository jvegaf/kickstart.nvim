local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    config = function()
      require('copilot').setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<A-f>',
            accept_word = '<A-w>',
            accept_line = '<A-l>',
            next = '<A-j>',
            prev = '<A-k>',
            dismiss = '<A-x>',
          },
        },
      })
    end,
  },
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>a', group = '+AI Avante' },
        { '<leader>A', group = '+AI Copilot Chat' },
        { 'gm', group = '+Copilot chat' },
        { 'gmh', desc = 'Show help' },
        { 'gmd', desc = 'Show diff' },
        { 'gmp', desc = 'Show system prompt' },
        { 'gms', desc = 'Show selection' },
        { 'gmy', desc = 'Yank diff' },
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      prompts = prompts,
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      mappings = {
        -- Use tab for completion
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        -- Close the chat
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
        },
        -- Accept the diff
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        -- Yank the diff in the response to register
        yank_diff = {
          normal = 'gmy',
        },
        -- Show the diff
        show_diff = {
          normal = 'gmd',
        },
        -- Show the info
        show_info = {
          normal = 'gmi',
        },
        -- Show the context
        show_context = {
          normal = 'gmc',
        },
        -- Show help
        show_help = {
          normal = 'gmh',
        },
      },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')
      local select = require('CopilotChat.select')
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      chat.setup(opts)

      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })
    end,
    event = 'VeryLazy',
    keys = {
      -- Show prompts actions with telescope
      {
        '<leader>Ap',
        function()
          local actions = require('CopilotChat.actions')
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>Ap',
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = 'x',
        desc = 'CopilotChat - Prompt actions',
      },
      -- Code related commands
      { '<leader>Ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>At', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>Ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>AR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
      { '<leader>An', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>Av',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>Ax',
        ':CopilotChatInline<cr>',
        mode = 'x',
        desc = 'CopilotChat - Inline chat',
      },
      -- Custom input for CopilotChat
      {
        '<leader>Ai',
        function()
          local input = vim.fn.input('Ask Copilot: ')
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Ask input',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>Am',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit message for all changes',
      },
      -- Quick chat with Copilot
      {
        '<leader>Aq',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Debug
      { '<leader>Ad', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
      -- Fix the issue with diagnostic
      { '<leader>Af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>Al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>Av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      -- Copilot Chat Models
      { '<leader>A?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    },
  },
  -- {
  --   "jonahgoldwastaken/copilot-status.nvim",
  --   dependencies = { "zbirenbaum/copilot.lua", "nvim-lualine/lualine.nvim" },
  --   lazy = true,
  --   event = "BufReadPost",
  --   opts = function()
  --     require("lualine").setup {
  --       sections = {
  --         lualine_x = {
  --           function() return require("copilot_status").status_string() end,
  --           cnd = function() return require("copilot_status").enabled() end,
  --         },
  --       },
  --     }
  --   end,
  -- },
}
