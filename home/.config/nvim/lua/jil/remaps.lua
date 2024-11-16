local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('i', 'jk', '<Esc>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- Split Navigation
map('n', '<C-j>', '<C-g>j', opts)
map('n', '<C-k>', '<C-g>k', opts)
map('n', '<C-h>', '<C-g>h', opts)
map('n', '<C-l>', '<C-g>l', opts)

-- nvim-tree keybindings
-- Main toggles
map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<Leader>fe', ':NvimTreeFocus<CR>', opts)

-- File operations in nvim-tree
map('n', '<Leader>fr', ':NvimTreeRefresh<CR>', opts)
map('n', '<Leader>fn', ':NvimTreeFindFile<CR>', opts) -- Find current file in tree

-- Telescope keybindings
-- File pickers
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<Leader>fl', ':Telescope live_grep<CR>', opts)
map('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<Leader>fh', ':Telescope help_tags<CR>', opts)

-- Git pickers
map('n', '<Leader>gc', ':Telescope git_commits<CR>', opts)
map('n', '<Leader>gb', ':Telescope git_branches<CR>', opts)
map('n', '<Leader>gs', ':Telescope git_status<CR>', opts)

-- Floating terminal
