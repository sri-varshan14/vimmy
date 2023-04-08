-- Using Neovim Leader Key as {Space}
vim.g.mapleader = ' '

local set = vim.opt

set.number = true
set.relativenumber = true
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.hlsearch = true
set.background = 'dark'
set.wildmenu = true
set.autoindent = true
set.cursorline = true
set.autowrite = true
set.mouse = 'a'

vim.env.FZF_DEFAULT_OPTS = '--layout=reverse'
