return {
  'nvim-mini/mini.align',
  version = '*',
  event = 'VeryLazy',
  opts = {
    mappings = {
      start = 'ga',
      start_with_preview = 'gA',
      -- These are advanced mappings that can be used to control
      -- alignment more precisely (see `:h mini.align.setup` for details).
      -- For basic usage, you can remove them.
      start_line = 'gI',
      start_line_with_preview = 'gi',
      align_to_char = 'gm',
      align_to_char_with_preview = 'gM',
    },
  },
}
