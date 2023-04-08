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
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = 
            function()
                require("nvim-tree").setup {}
            end,
        lazy = true,
    },
    { "catppuccin/nvim", as = "catppuccin", lazy = true },
    { 'feline-nvim/feline.nvim', lazy = true },
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
    {'akinsho/bufferline.nvim', version = "v3.*", dependencies = 'nvim-tree/nvim-web-devicons'}
})
