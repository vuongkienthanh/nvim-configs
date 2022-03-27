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
set.colorcolumn = "80"
set.termguicolors = true
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("lead: ")
set.listchars:append("multispace:…")
-- tab
set.expandtab = true
set.tabstop=2
set.shiftwidth=2
set.autoindent = true
set.smartindent = true

-- ./lua/plugins.lua
require('plugins')

-- ./lua/my_remap.lua
require('my_remap')

-- for wsl clipboard
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf"
    },
    paste = {
      ["+"] = "win32yank.exe -o --crlf",
      ["*"] = "win32yank.exe -o --crlf"
    },
    cache_enable = 0,
  }
end
