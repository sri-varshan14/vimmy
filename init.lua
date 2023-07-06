require("config")
require("plugins")
require("themes")

vim.cmd [[colorscheme rose-pine]]
vim.cmd [[cabbrev wq execute "Format sync tab_width=4" <bar> wq]]
