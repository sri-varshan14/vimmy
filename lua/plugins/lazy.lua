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
        "nvim-neo-tree/neo-tree.nvim",
        version = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                's1n7ax/nvim-window-picker',
                version = "v1.*",
                config = function()
                    require 'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        },
        lazy = true,
    },
    { "catppuccin/nvim",                 as = "catppuccin", lazy = true },
    { 'feline-nvim/feline.nvim',         lazy = true },
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
    { 'akinsho/bufferline.nvim',         version = "v3.*",  dependencies = 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },
    { "windwp/nvim-autopairs",         config = function() require("nvim-autopairs").setup {} end, lazy = true },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
    },
    { "lukas-reineke/lsp-format.nvim", lazy = true },
    { 'neovim/nvim-lspconfig',         dependencies = 'simrat39/rust-tools.nvim',                  lazy = true },
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.2',
        config = function()
            require('distant').setup {
                ['*'] = require('distant.settings').chip_default()
            }
        end
    },
    { 'kdheepak/lazygit.nvim' },
    {
        'lewis6991/gitsigns.nvim',
    },
})
