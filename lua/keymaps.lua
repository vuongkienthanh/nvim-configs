vim.g.mapleader = ' '
local map = vim.keymap.set
local opts = { silent = true }

-- windows
map('n', '<leader>j', '<C-W><C-j>', opts)
map('n', '<leader>k', '<C-W><C-k>', opts)
map('n', '<leader>h', '<C-W><C-h>', opts)
map('n', '<leader>l', '<C-W><C-l>', opts)
-- move line
map('v', '<C-j>', ":m '>+1<CR>gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv", opts)
-- better default keymaps
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('n', 'zz', 'zzzH', opts)
map('n', '<C-l>', ':ccl<CR>:lcl<CR>:nohls<CR><C-l>', opts)
map('n', 'J', 'mxJ`x', opts)
-- copy visual selected to clipboard
map('v', '<C-Y>', '"+y', opts)
-- paste last yanked
map('n', '<C-P>', '"0p', opts)
-- Undo break point
map('i', ',', ',<C-G>u', opts)
map('i', ';', ';<C-G>u', opts)
map('i', ':', ':<C-G>u', opts)
map('i', '.', '.<C-G>u', opts)
map('i', '!', '!<C-G>u', opts)
map('i', '?', '?<C-G>u', opts)
map('i', '<CR>', '<CR><C-G>u', opts)
-- add char at the end
map('n', ';;', 'mxA;<ESC>`x', opts)
map('n', ',,', 'mxA,<ESC>`x', opts)
