local keymap = vim.keymap.set

keymap('n', '<Leader>w', ':w<CR>')
keymap('n', '<Leader>s', ':wall<CR>')

keymap('n', '<Leader>e', ':Neotree toggle<CR>')

keymap('n', '<Leader><Space>', ':Telescope find_files<CR>')
keymap('n', '<Leader>ff', ':Telescope find_files<CR>')
keymap('n', '<Leader>fl', ':Telescope live_grep<CR>')
keymap('n', '<Leader>fb', ':Telescope buffers<CR>')
keymap('n', '<Leader>fc', ':Telescope colorscheme<CR>')
