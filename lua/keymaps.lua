-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local NS = { noremap = true, silent = true }
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', ':q!<CR>', NS) -- quit without saving
-- keymap.set("n", "<localleader>w", ":w<CR>", NS)           -- save
-- keymap.set("n", "<localleader>q", ":Bdelete<CR>", NS)     -- close buffer
vim.keymap.set('n', 'W', ':w<CR>', NS) -- save
vim.keymap.set('n', 'Q', ':bdelete<CR>', NS) -- close buffer
vim.keymap.set('n', 'vv', 'V', NS) -- close buffer

-- Buffers
-- vim.keymap.set('n', '<leader>e', ':Neotree<CR>', NS) -- close buffer
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', NS) -- close buffer
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<cr>', NS)
vim.keymap.set('n', 'L', ':BufferLineCycleNext<cr>', NS)
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move Lines
vim.keymap.set('n', '<M-j>', ':m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('n', '<M-k>', ':m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('v', '<M-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', '<M-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Jumplist
vim.keymap.set('n', '<C-m>', '<C-i>', NS)

-- Treesj
vim.keymap.set('n', '<leader>j', function()
  require('treesj').toggle({ split = { recusive = true } })
end, { noremap = true, silent = true, desc = 'Toggle Split Join' })

-- dont yank on visual paste
vim.keymap.set('v', 'p', '"_dP', NS)

-- Cancel search highlighting with ESC
vim.keymap.set('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', NS)

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G', NS)

vim.keymap.set('v', '<', '<gv', { desc = 'Stay in indent mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in indent mode' })

-- LSP
vim.keymap.set('n', '<leader>li', ':LspInfo<cr>', { desc = 'LSP Info' })
vim.keymap.set('n', '<leader>lr', ':LspReset<cr>', { desc = 'LSP Reset' })

-- System
vim.keymap.set('n', '<leader>zc', ':e $MYVIMRC<cr>', { noremap = true, silent = true, desc = 'Config' })
vim.keymap.set('n', '<leader>zh', ':checkhealth<cr>', { noremap = true, silent = true, desc = 'Health' })
vim.keymap.set('n', '<leader>zm', ':Mason<cr>', { noremap = true, silent = true, desc = 'Mason' })
vim.keymap.set('n', '<leader>zl', ':Lazy<cr>', { noremap = true, silent = true, desc = 'Lazy' })
vim.keymap.set('n', '<leader>za', ':messages<cr>', { desc = 'Messages' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
