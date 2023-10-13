--         ╭──────────────────────────────────────────────────────────╮
--         │                    Setting Leader Key                    │
--         ╰──────────────────────────────────────────────────────────╯
vim.g.mapleader = ' ' --  Setting the {Space} Key as Leader Key

--         ╭──────────────────────────────────────────────────────────╮
--         │                     General Settings                     │
--         ╰──────────────────────────────────────────────────────────╯
local set = vim.opt       -- Local variable are pretty good to use
set.mouse = 'a'           -- Enabling mouse
set.number = true         -- Enable line number
set.relativenumber = true -- Enable relative line number
set.tabstop = 4           -- Tab space length
set.shiftwidth = 4        -- Auto shift space length
set.expandtab = true      -- Insert space character when tab key is pressed
set.wildmenu = true       -- Enable wildmenu [Command Line Complection]
set.autoindent = true     -- Enable Auto Indent
set.cursorline = true     -- Enable cursorline
set.fillchars = 'eob: '   -- To remove the ~ symbol in unused line
set.background = 'dark'   -- Who tf want 'light' theme
set.termguicolors = true  -- Enable better coloring

--         ╭──────────────────────────────────────────────────────────╮
--         │                Plugin Manager - Lazy.nvim                │
--         ╰──────────────────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    -- File-Traversal Plugins
    {
        'nvim-tree/nvim-tree.lua',
        name = 'nvim-tree',
        dependencies = {
            'nvim-tree/nvim-web-devicons' }
    },
    {
        'ThePrimeagen/harpoon',
        name = 'harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- LSP PLugins
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'lukas-reineke/lsp-format.nvim',
        'nvim-treesitter/nvim-treesitter',
        'mfussenegger/nvim-dap',
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-telescope/telescope-dap.nvim",
        'theHamsta/nvim-dap-virtual-text',
    },
    { "folke/trouble.nvim",            dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Dev Tools Plugins
    { 'lewis6991/gitsigns.nvim' },
    {
        'windwp/nvim-autopairs',
        'windwp/nvim-ts-autotag'
    },

    -- Productivity Plugins
    { 'psliwka/vim-smoothie' },

    -- Awesome Plugins
    { 'LudoPinelli/comment-box.nvim' },

    -- Themes Plugins
    { 'catppuccin/nvim',             name = 'catppuccin' },
    { 'rose-pine/neovim',            name = 'rose-pine' },
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                     NvimTree Config                      │
--         ╰──────────────────────────────────────────────────────────╯
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>')
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup {
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    sort = {
        sorter = "name",
        folders_first = true,
    },
    root_dirs = {},
    prefer_startup_root = true,
    sync_root_with_cwd = false,
    reload_on_bufenter = true,
    respect_buf_cwd = false,
    on_attach = "default",
    select_prompts = false,
    view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 35,
        side = "right",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
    },
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        git_ignored = true,
        dotfiles = true,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
    },
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
    },
    git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash = {
        cmd = "gio trash",
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    tab = {
        sync = {
            open = false,
            close = false,
            ignore = {},
        },
    },
    notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
    },
    ui = {
        confirm = {
            remove = true,
            trash = true,
        },
    },
    experimental = {},
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}

--         ╭──────────────────────────────────────────────────────────╮
--         │                      Harpoon Config                      │
--         ╰──────────────────────────────────────────────────────────╯
vim.keymap.set('n', 'hm', require("harpoon.mark").add_file)
vim.keymap.set('n', 'hu', require("harpoon.ui").toggle_quick_menu)
vim.keymap.set('n', 'hn', require("harpoon.ui").nav_next)
vim.keymap.set('n', 'hp', require("harpoon.ui").nav_prev)
require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
        mark_branch = false,
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
    }
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                     Telescope Config                     │
--         ╰──────────────────────────────────────────────────────────╯
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local trouble = require("trouble.providers.telescope")
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                ["<c-t>"] = trouble.open_with_trouble,
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            },
            n = {
                ["<c-t>"] = trouble.open_with_trouble
            },
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

-- ========== Mason Config ==========
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
require("mason").setup({
    ensure_installed = {},
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
    pip = {                                                                      -- Installing package with pip
        upgrade_pip = true,
        install_args = {},                                                       -- Provide more arg to pip like proxy..
    },
    ui = {                                                                       --  Setting for the Mason Window
        check_outdated_packages_on_open = true,
        border = "rounded",                                                      -- Check ":h nvim_open_win()"
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                        DAP Config                        │
--         ╰──────────────────────────────────────────────────────────╯
local keymap = vim.keymap.set
local present_dapui, dapui = pcall(require, "dapui")
local present_dap, dap = pcall(require, "dap")
local present_virtual_text, dap_vt = pcall(require, "nvim-dap-virtual-text")
local _, shade = pcall(require, "shade")
local opts = { noremap = true, silent = true }
if not present_dapui or not present_dap or not present_virtual_text then
    return
end
keymap("n", "<Leader>db", require('dap').toggle_breakpoint, opts)
keymap("n", "<Leader>dc", require('dap').continue, opts)
keymap("n", "<Leader>dd", require('dap').continue, opts)
keymap("n", "<Leader>di", require('dap').step_into, opts)
keymap("n", "<Leader>do", require('dap').step_out, opts)
keymap("n", "<Leader>dO", require('dap').step_over, opts)
keymap("n", "<Leader>dt", require('dap').terminate, opts)
keymap("n", "<Leader>dh", require('dapui').eval, opts)
keymap("n", "<Leader>dC", require('dapui').close, opts)
dap_vt.setup({
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- Experimental Features:
    virt_text_pos = "eol",                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil,               -- position the virtual text at a fixed window column (starting from the first text column) ,
})
dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,   -- These can be integers or a float between 0 and 1.
        max_width = nil,    -- Floats will be treated as percentage of your screen.
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
})
dap.set_log_level("TRACE")
-- Automatically open UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

--         ╭──────────────────────────────────────────────────────────╮
--         │                     Mason DAP Config                     │
--         ╰──────────────────────────────────────────────────────────╯
require("mason-nvim-dap").setup({
    handlers = {},
    ensure_installed = {}
})
vim.g.dap_virtual_text = true
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

--         ╭──────────────────────────────────────────────────────────╮
--         │                    Treesitter Config                     │
--         ╰──────────────────────────────────────────────────────────╯
require 'nvim-treesitter.configs'.setup { -- Treesitter This gives syntax highlight
    ensure_installed = {},
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                  Mason-LSPConfig Config                  │
--         ╰──────────────────────────────────────────────────────────╯
require("mason-lspconfig").setup { -- mason-lspconfig install all the language server that I mentioned here
    ensure_installed = {
        "lua_ls",
    },
    automatic_installation = true,
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                    LSP-Format Config                     │
--         ╰──────────────────────────────────────────────────────────╯
require("lsp-format").setup { -- lsp-format is used for formating the files
    typescript = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    yaml = { tab_width = 4 },
    cpp = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    c = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    cmake = { tab_width = 4 },
    rust = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    svelte = { tab_width = 4 },
    html = { tab_width = 4 },
}

--         ╭──────────────────────────────────────────────────────────╮
--         │                        CMP Config                        │
--         ╰──────────────────────────────────────────────────────────╯
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                  LSP-Attachment Config                   │
--         ╰──────────────────────────────────────────────────────────╯
local on_attach = function(client)
    require("lsp-format").on_attach(client)
end
local prettier = {
    formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
    formatStdin = true,
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')[<YOUR_LSP_SERVER>].setup {
--    capabilities = capabilities,
--    on_attach = on_attach
--}
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

--         ╭──────────────────────────────────────────────────────────╮
--         │                       Trouble Config                     │
--         ╰──────────────────────────────────────────────────────────╯
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
require('trouble').setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q",                   -- close the list
        cancel = "<esc>",              -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",                 -- manually refresh
        jump = { "<cr>", "<tab>" },    -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" },      -- open buffer in new split
        open_vsplit = { "<c-v>" },     -- open buffer in new vsplit
        open_tab = { "<c-t>" },        -- open buffer in new tab
        jump_close = { "o" },          -- jump to the diagnostic and close the list
        toggle_mode = "m",             -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s",         -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P",          -- toggle auto_preview
        hover = "K",                   -- opens a small popup with the full multiline message
        preview = "p",                 -- preview the diagnostic location
        close_folds = { "zM", "zm" },  -- close all folds
        open_folds = { "zR", "zr" },   -- open all folds
        toggle_fold = { "zA", "za" },  -- toggle fold of current file
        previous = "k",                -- previous item
        next = "j"                     -- next item
    },
    indent_lines = true,               -- add an indent guide below the fold icons
    auto_open = false,                 -- automatically open the list when you have diagnostics
    auto_close = false,                -- automatically close the list when you have no diagnostics
    auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false,                 -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                     GitSigns Config                      │
--         ╰──────────────────────────────────────────────────────────╯
require('gitsigns').setup {
    signs                        = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },
    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })
        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })
        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

--         ╭──────────────────────────────────────────────────────────╮
--         │                  --Nvim-Autopair Config                  │
--         ╰──────────────────────────────────────────────────────────╯
require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})
require('nvim-ts-autotag').setup()

--         ╭──────────────────────────────────────────────────────────╮
--         │                    Comment-box Config                    │
--         ╰──────────────────────────────────────────────────────────╯
local keymap = vim.keymap.set
local cb = require("comment-box")

keymap({ "n", "v" }, "<Leader>bb", cb.lbox, {})
keymap({ "n", "v" }, "<Leader>bc", cb.ccbox, {})

keymap("n", "<Leader>bl", cb.cline, {})
keymap("i", "<M-l>", cb.cline, {})

--         ╭──────────────────────────────────────────────────────────╮
--         │                  Catppuccin Theme Config                 │
--         ╰──────────────────────────────────────────────────────────╯
require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {     -- :h background
        light = 'latte',
        dark = 'mocha',
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,            -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,          -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },    -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integration_default = nil, -- set to true/false to enable/disable integrations by default
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = true,
        telescope = {
            enabled = true,
            style = 'nvchad'
        },
        lsp_trouble = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- ========== Rosepine Theme Config ==========
require('rose-pine').setup({
    --- @usage 'auto'|'main'|'moon'|'dawn'
    variant = 'auto',
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,
    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = 'base',
        background_nc = '_experimental_nc',
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',
        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',
        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
    },
    -- Whether or not highlight_groups optios should change only only update
    -- the settings they touch or should reset the entire highlight_group.
    respect_default_highlight_groups = true,
    -- Change specific vim highlight groups
    -- https://github.com/rose-pine/neovim/wiki/Recipes
    highlight_groups = {
        ColorColumn = { bg = 'rose' },
        -- Blend colours against the 'base' background
        CursorLine = { bg = 'foam', blend = 10 },
        StatusLine = { fg = 'love', bg = 'love', blend = 10 },
    }
})

--         ╭──────────────────────────────────────────────────────────╮
--         │                    Enable Colorscheme                    │
--         ╰──────────────────────────────────────────────────────────╯
vim.cmd('colorscheme catppuccin')
