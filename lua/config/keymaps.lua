local keymap = vim.keymap.set

keymap('n', '<Leader>w', ':w<CR>')
keymap('n', '<Leader>s', ':wall<CR>')

keymap('n', '<Leader>e', ':NvimTreeToggle<CR>')
