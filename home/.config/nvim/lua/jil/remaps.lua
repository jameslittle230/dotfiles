local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  vim.keymap.set(mode, l, r, opts)
end

local telescope = require('telescope.builtin')
local lazy = require('lazy')

map('i', 'jk', '<Esc>')
map('n', 's', '<Plug>(leap)')

-- Split Navigation
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Core Vim-style mappings
-- Navigation
map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map('n', ']b', ':bnext<CR>', { desc = "Next buffer" })
map('n', '[b', ':bprevious<CR>', { desc = "Previous buffer" })

-- Standard operations
map('n', ',zz', function() lazy.update() end, { desc = "Update lazy.nvim" })

-- Window/Split Management (,w prefix)
map('n', ',wv', ':vsplit<CR>', { desc = "Split vertical" })
map('n', ',wh', ':split<CR>', { desc = "Split horizontal" })
map('n', ',wc', ':close<CR>', { desc = "Close window" })
map('n', ',wo', ':only<CR>', { desc = "Close other windows" })
map('n', ',w=', '<C-w>=', { desc = "Equal width" })
map('n', ',wm', ':WindowsMaximize<CR>', { desc = "Maximize window" })
map('n', ',wt', ':WindowsToggleAutowidth<CR>', { desc = "Toggle auto width" })

-- Buffer Management (,b prefix)
map('n', ',bd', ':bdelete<CR>', { desc = "Delete buffer" })
map('n', ',bD', ':bdelete!<CR>', { desc = "Delete buffer (force)" })
map('n', ',bo', ':%bd|e#|bd#<CR>', { desc = "Delete other buffers" })
map('n', ',bl', function() telescope.buffers() end, { desc = "List buffers" })
map('n', ',br', ':BufferRestore<CR>', { desc = "Restore last buffer" })

-- Quick Actions (,space for frequent operations)

-- Diagnostics
map('n', ',dd', function() vim.diagnostic.open_float({ border = "rounded" }) end, { desc = "Line diagnostics" })
map('n', ',dw', function() telescope.diagnostics() end, { desc = "Workspace diagnostics" })

-- j/k
vim.keymap.set('n', 'k', function()
  return vim.v.count and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

vim.keymap.set('n', 'j', function()
  return vim.v.count and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })
