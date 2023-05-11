require("lsp-format").setup {
    typescript = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    yaml = { tab_width = 4 },
    cpp = { tab_width = 4 }
}
