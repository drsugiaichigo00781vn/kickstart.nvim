-- delete single character without copying into register
-- For conciseness
local opts = { noremap = true, silent = true }

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- Buffers
vim.keymap.set('n', '<C-x>', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<C-n>', '<cmd> enew <CR>', opts) -- new buffer

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
