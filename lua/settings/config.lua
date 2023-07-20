-- Using Neovim Leader Key as {Space}
vim.g.mapleader = ' '

local set = vim.opt

set.mouse = 'a'
set.tabstop = 4
set.number = true
set.shiftwidth = 4
set.expandtab = true
set.wildmenu = true
set.autoindent = true
set.cursorline = true
set.fillchars = 'eob: ' -- To remove the ~ symbol in unused line 
set.background = 'dark'
set.termguicolors = true
set.relativenumber = true

--We added NvimTree Plugins So we disable the default neovim file directory explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
