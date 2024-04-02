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
set.smartindent = true

vim.g.python3_host_prog = "python3"

vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
}

require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(lazypath)
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
