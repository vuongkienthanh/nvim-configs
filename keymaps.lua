vim.g.mapleader = " "

local map = function(mode, km, ex)
    vim.keymap.set(mode, km, ex, { silent = true })
end

-- quicker window moving
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>l", ":wincmd l<CR>")
-- move line
map("v", "<C-j>", ":m '>+1<CR>gv")
map("v", "<C-k>", ":m '<-2<CR>gv")
-- better default keymaps
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "zz", "zzzH")
map("n", "<C-l>", ":nohls<CR><C-l>")
map("n", "J", "mxJ`x")
-- copy visual selected to clipboard
map("v", "<C-Y>", '"+ygv<ESC>')
-- better linewise yank
map("v", "y", "ygv<ESC>")
-- paste last yanked
map("n", "<C-P>", '"0p')
-- Undo break point
map("i", ",", ",<C-G>u")
map("i", ";", ";<C-G>u")
map("i", ":", ":<C-G>u")
map("i", ".", ".<C-G>u")
map("i", "!", "!<C-G>u")
map("i", "?", "?<C-G>u")
map("i", "<CR>", "<CR><C-G>u")
-- add char at the end
map("n", ";;", "mxA;<ESC>`x")
map("n", ",,", "mxA,<ESC>`x")
-- insert at second end
map("n", "Z", "<End>i")
