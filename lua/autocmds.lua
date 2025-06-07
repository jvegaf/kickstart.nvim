-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = vim.api.nvim_create_augroup
local autocmds = vim.api.nvim_create_autocmd
augroup('discontinue_comments', { clear = true })
autocmds({ 'FileType' }, {
  pattern = { '*' },
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - 'o'
  end,
  group = 'discontinue_comments',
  desc = "Dont't continue comments with o/O",
})

local lastplace = augroup('LastPlace', {})
vim.api.nvim_clear_autocmds({ group = lastplace })
autocmds('BufReadPost', {
  group = lastplace,
  pattern = { '*' },
  desc = 'remember last cursor place',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmds('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_auto_diag', { clear = true }),
  callback = function(args)
    -- the buffer where the lsp attached
    ---@type number
    local buffer = args.buf

    -- create the autocmd to show diagnostics
    vim.api.nvim_create_autocmd('CursorHold', {
      group = vim.api.nvim_create_augroup('_auto_diag', { clear = true }),
      buffer = buffer,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
})

-- Turn off paste mode when leaving insert
autocmds('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
autocmds('FileType', {
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

autocmds('FileType', {
  pattern = { 'help' },
  callback = function()
    vim.opt.wildignore = vim.opt.wildignore + '*.txt'
  end,
})
