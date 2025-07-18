return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'ravitemer/mcphub.nvim',
    'ravitemer/codecompanion-history.nvim',
    {
      'Davidyz/VectorCode',
      version = '*', -- optional, depending on whether you're on nightly or release
      -- build = 'pipx upgrade vectorcode', -- This helps keeping the CLI up-to-date
      build = 'uv tool upgrade vectorcode', -- This helps keeping the CLI up-to-date
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      'OXY2DEV/markview.nvim',
      lazy = false,
      opts = {
        experimental = {
          check_rtp_message = false,
        },
        preview = {
          filetypes = { 'markdown', 'codecompanion' },
          ignore_buftypes = {},
        },
      },
    },
    {
      'echasnovski/mini.diff',
      config = function()
        local diff = require('mini.diff')
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
    {
      'HakonHarnes/img-clip.nvim',
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = '[Image]($FILE_PATH)',
            use_absolute_path = true,
          },
        },
      },
    },
  },
  init = function()
    vim.cmd([[cab cc CodeCompanion]])

    local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'CodeCompanionInlineFinished',
      group = group,
      callback = function(request)
        vim.lsp.buf.format({ bufnr = request.buf })
      end,
    })
  end,
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
    'CodeCompanionCmd',
  },
  keys = {
    { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'AI Toggle [C]hat' },
    { '<leader>an', '<cmd>CodeCompanionChat<cr>', mode = { 'n', 'v' }, desc = 'AI [N]ew Chat' },
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'AI [A]ction' },
    { 'ga', '<cmd>CodeCompanionChat Add<CR>', mode = { 'v' }, desc = 'AI [A]dd to Chat' },
    -- prompts
    { '<leader>ae', '<cmd>CodeCompanion /explain<cr>', mode = { 'v' }, desc = 'AI [E]xplain' },
  },
  config = true,
  opts = {
    adapters = {
      copilot_37 = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'claude-3.7-sonnet',
            },
          },
        })
      end,
      copilot_4 = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'claude-sonnet-4',
            },
          },
        })
      end,
      copilot_gemini_25_pro = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'gemini-2.5-pro',
            },
          },
        })
      end,
    },
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = 'vertical', -- vertical|horizontal split for default provider
        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
        provider = 'default', -- default|mini_diff
      },
      chat = {
        window = {
          position = 'left',
        },
      },
    },
    strategies = {
      inline = {
        keymaps = {
          accept_change = {
            modes = { n = 'ga' },
            description = 'Accept the suggested change',
          },
          reject_change = {
            modes = { n = 'gr' },
            description = 'Reject the suggested change',
          },
        },
      },
      chat = {
        slash_commands = {
          ['git_files'] = {
            description = 'List git files',
            ---@param chat CodeCompanion.Chat
            callback = function(chat)
              local handle = io.popen('git ls-files')
              if handle ~= nil then
                local result = handle:read('*a')
                handle:close()
                chat:add_reference({ role = 'user', content = result }, 'git', '<git_files>')
              else
                return vim.notify('No git files available', vim.log.levels.INFO, { title = 'CodeCompanion' })
              end
            end,
            opts = {
              contains_code = false,
            },
          },
        },
        keymaps = {
          send = {
            modes = { n = '<CR>', i = '<C-s>' },
          },
          close = {
            modes = { n = '<C-c>', i = '<C-c>' },
          },
          -- Add further custom keymaps here
        },
        adapter = 'copilot',
        roles = {
          ---The header name for the LLM's messages
          ---@type string|fun(adapter: CodeCompanion.Adapter): string
          llm = function(adapter)
            return 'AI (' .. adapter.formatted_name .. ')'
          end,

          ---The header name for your messages
          ---@type string
          user = 'User',
        },
        tools = {
          groups = {
            ['full_stack_dev'] = {
              description = 'Full Stack Developer - Can run code, edit code and modify files',
              system_prompt = "**DO NOT** make any assumptions about the dependencies that a user has installed. If you need to install any dependencies to fulfil the user's request, do so via the Command Runner tool. If the user doesn't specify a path, use their current working directory.",
              tools = {
                'cmd_runner',
                'editor',
                'files',
              },
            },
            ['gentleman'] = {
              description = 'The Gentleman',
              system_prompt = "Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.\n\nHabla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como 'buenas acá estamos' o 'dale que va' según el contexto.\n\nSus principales áreas de conocimiento incluyen:\n- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals, State Managers propios como Gentleman State Manager y GPX-Store).\n- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.\n- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.\n- Loco por la modularización, atomic design y el patrón contenedor presentacional \n- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.\n- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.\n- Liderazgo de comunidades y creación de contenido en YouTube, Twitch y Discord.\n\nA la hora de explicar un concepto técnico:\n1. Explica el problema que el usuario enfrenta.\n2. Propone una solución clara y directa, con ejemplos si aplica.\n3. Menciona herramientas o recursos que pueden ayudar.\n\nSi el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.\n\nAdemás, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, cómo balancear liderazgo y comunidad, y cómo mantenerse actualizado en tecnología mientras se experimenta con nuevas herramientas. Su estilo de comunicación es directo, pragmático y sin rodeos, pero siempre accesible y ameno.\n\nEsta es una transcripción de uno de sus vídeos para que veas como habla:\n\nLe estaba contando la otra vez que tenía una condición Que es de adulto altamente calificado no sé si lo conocen pero no es bueno el oto lo está hablando con mi mujer y y a mí cuando yo era chico mi mamá me lo dijo en su momento que a mí me habían encontrado una condición Que ti un iq muy elevado cuando era muy chico eh pero muy elevado a nivel de que estaba 5 años o 6 años por delante de un niño",
              tools = {
                'cmd_runner',
                'editor',
                'files',
              },
            },
          },
          ['cmd_runner'] = {
            callback = 'strategies.chat.agents.tools.cmd_runner',
            description = 'Run shell commands initiated by the LLM',
            opts = {
              requires_approval = true,
            },
          },
          ['editor'] = {
            callback = 'strategies.chat.agents.tools.editor',
            description = "Update a buffer with the LLM's response",
          },
          ['files'] = {
            callback = 'strategies.chat.agents.tools.files',
            description = "Update the file system with the LLM's response",
            opts = {
              requires_approval = true,
            },
          },
          -- ['mcp'] = { -- Name this tool whatever you like
          --   -- Callback provides the necessary functions to CodeCompanion
          --   callback = function()
          --     return require('mcphub.extensions.codecompanion')
          --   end,
          --   opts = {
          --     -- If true, CodeCompanion will ask for approval before executing the MCP tool call
          --     requires_approval = true,
          --     -- Optional: Pass parameters like temperature to the underlying LLM if the chat strategy supports it
          --     temperature = 0.7,
          --   },
          -- },
        },
      },
    },
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = 'gh',
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = 'sc',
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = true,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 0,
          -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
          picker = 'telescope',
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to active chat's adapter)
            adapter = nil, -- e.g "copilot"
            ---Model for generating titles (defaults to active chat's model)
            model = nil, -- e.g "gpt-4o"
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
          ---Enable detailed logging for history extension
          enable_logging = false,
        },
      },
      vectorcode = {
        opts = {
          add_tool = true,
        },
      },
    },
  },
}
