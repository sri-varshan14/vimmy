require("config")
require("plugins")
require("themes")

vim.cmd [[colorscheme catppuccin]]
vim.cmd [[cabbrev wq execute "Format sync tab_width=4" <bar> wq]]
