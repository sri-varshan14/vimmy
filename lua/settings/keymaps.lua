vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('n', '<Leader>s', ':wall<CR>')

vim.keymap.set('n', '<Leader><space>', ": Telescope find_files<CR>", {})
vim.keymap.set('n', '<Leader>"', ":Telescope live_grep<CR>", {})
vim.keymap.set('n', '<Leader>,', ":Telescope buffers<CR>", {})
