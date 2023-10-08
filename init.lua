-- ========== Setting Leader Key ==========
    vim.g.mapleader = ' ' --  Setting the {Space} Key as Leader Key
-- ========================================


-- ========== General Settings ==========
    local set = vim.opt -- Local variable are pretty good to use
    set.mouse = 'a'			    -- Enabling mouse
    set.number = true           -- Enable line number
    set.relativenumber = true   -- Enable relative line number
    set.tabstop = 4			    -- Tab space length
    set.shiftwidth = 4          -- Auto shift space length
    set.expandtab = true        -- Insert space character when tab key is pressed
    set.wildmenu = true         -- Enable wildmenu [Command Line Complection]
    set.autoindent = true       -- Enable Auto Indent
    set.cursorline = true       -- Enable cursorline
    set.fillchars = 'eob: ' 	-- To remove the ~ symbol in unused line 
    set.background = 'dark'     -- Who tf want 'light' theme
    set.termguicolors = true    -- Enable better coloring
-- ======================================


-- ========== Plugin Manager - Lazy.nvim ==========
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
        { 'nvim-tree/nvim-tree.lua', name = 'nvvim-tree', dependencies = { 'nvim-tree/nvim-web-devicons' } },

        -- Themes Plugins
        { 'catppuccin/nvim', name = 'catppuccin' },
        { 'rose-pine/neovim', name = 'rose-pine' },
    })
-- ================================================


-- ========== File-Traversal Plugins Section ==========
    -- ========== NvimTree Config ==========

        vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>')

        -- disable netrw at the very start of your init.lua
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
    -- =====================================
    
-- ====================================================


-- ========== Theme Plugins Section ==========

    -- ========== Catppuccin Theme Config ==========
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
    -- =============================================

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
    -- ===========================================

    -- ========== Enable Colorscheme ==========
        vim.cmd('colorscheme catppuccin')
    -- ========================================

-- ===========================================
