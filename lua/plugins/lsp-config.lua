local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

require("mason").setup({
    ensure_installed = {
        "codelldb"
    },
    PATH = "prepend",               -- Where Mason should put its bin location in you PATH (default: prepend, append, skip)
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 10, -- Number of concurrent install
    registries = {                  -- Registries default contains only mason-registry
        "github:mason-org/mason-registry",
    },
    providers = { -- Provider implementations details
        "mason.providers.registry-api",
        "mason.providers.client",
    },
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s", -- Template to download LSP (here repo_name, release_version,package_name
    },

    pip = {                -- Installing package with pip
        upgrade_pip = true,
        install_args = {}, -- Provide more arg to pip like proxy..
    },

    ui = {                  --  Setting for the Mason Window
        check_outdated_packages_on_open = true,
        border = "rounded", -- Check ":h nvim_open_win()"
        width = 0.8,
        height = 0.9,

        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },

        keymaps = { -- Keybinding for operation on Mason Installer
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
})
require 'nvim-treesitter.configs'.setup { -- Treesitter This gives syntax highlight
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "cmake", "cpp", "css", "cuda", "dockerfile",
        "fish", "yaml", "typescript", "toml", "svelte", "sql", "rust", "python", "make", "markdown", "json",
        "javascript", "ninja" },
    sync_install = true,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        --disable = function(lang, buf)
        --    local max_filesize = 100 * 1024 -- 100 KB
        --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --    if ok and stats and stats.size > max_filesize then
        --        return true
        --    end
        --end,
        additional_vim_regex_highlighting = false,
    },
}

require("mason-lspconfig").setup { -- mason-lspconfig install all the language server that I mentioned here
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "neocmake",
        "bashls",
        "cssls",
        "cssmodules_ls",
        "dockerls",
        "html",
        "jsonls",
        "marksman",
        "pyright",
        "yamlls",
        "tsserver",
        "tailwindcss",
        "taplo",
        "svelte",
        "sqlls"
    },
    automatic_installation = true,
}

require("lsp-format").setup { -- lsp-format is used for formating the files
    typescript = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    yaml = { tab_width = 4 },
    cpp = { tab_width = 4 },
    c = { tab_width = 4 },
    cmake = { tab_width = 4 },
    rust = { tab_width = 4 },
    svelte = { tab_width = 4 },
    html = { tab_width = 4 },
}

vim.keymap.set('n', '<Leader>?', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>dq', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

local cmp = require 'cmp'
cmp.setup({ -- AutoComplection PopUP
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'path' },
        { name = 'buffer' },

    })
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
-- Set up lspconfig.
local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

local prettier = {
    formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
    formatStdin = true,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require('lspconfig')['neocmake'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['bashls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['cssls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['cssmodules_ls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['dockerls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['html'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['jsonls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['marksman'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    init_options = { documentFormatting = true },
    settings = {
        languages = {
            typescript = { prettier },
            yaml = { prettier },
        },
    },
}
require('lspconfig')['tailwindcss'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['taplo'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['svelte'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
require('lspconfig')['sqlls'].setup {
    capabilities = capabilities,
    on_attach = on_attach
}
