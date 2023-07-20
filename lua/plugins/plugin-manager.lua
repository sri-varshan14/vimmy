local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup({
    {"nvim-tree/nvim-tree.lua", dependencies="nvim-tree/nvim-web-devicons", lazy=false },
    {'nvim-lualine/lualine.nvim',requires = { 'nvim-tree/nvim-web-devicons', opt = true }, lazy=false},
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', lazy=false},

    -- Themes
    { 'rose-pine/neovim', name = 'rose-pine' }
})

