local set = vim.opt
set.number = true
set.relativenumber = true
set.mouse = 'a'
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.incsearch = true
set.swapfile = false
set.backup = false
set.writebackup = false
set.showmode = false
set.cmdheight=2
set.hidden = true
set.cursorline = true
set.shortmess:append('c')
set.encoding='utf-8'
set.termguicolors = true
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("lead: ")
set.listchars:append("multispace:…")
set.listchars:append("tab:>~")
-- tab
set.expandtab = true
set.tabstop=2
set.shiftwidth=2
set.autoindent = true
set.smartindent = true

vim.g.python3_host_prog = 'python'

-- ./lua/plugins.lua
require('plugins')

-- ./lua/my_remap.lua
require('my_remap')
