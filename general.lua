local set = vim.opt
set.number = true
set.relativenumber = true
set.mouse = "a"
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.incsearch = true
set.swapfile = false
set.backup = false
set.writebackup = false
set.showmode = false
set.cmdheight = 2
set.hidden = true
set.cursorline = true
set.shortmess:append("c")
set.encoding = "utf-8"
set.termguicolors = true
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("lead: ")
set.listchars:append("multispace:…")
set.listchars:append("tab:>~")
-- tab
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.smartindent = false
-- undo
set.undofile = true
set.undolevels = 1000
