local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  vim.keymap.set(mode, l, r, opts)
end

local telescope = require('telescope.builtin')
local lazy = require('lazy')

map('i', 'jk', '<Esc>')
map('n', 's', '<Plug>(leap)')
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Split Navigation
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Resize windows using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Navigation
map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map('n', ']b', ':bnext<CR>', { desc = "Next buffer" })
map('n', '[b', ':bprevious<CR>', { desc = "Previous buffer" })
map('n', '<S-L>', ':bnext<CR>', { desc = "Next buffer" })
map('n', '<S-H>', ':bprevious<CR>', { desc = "Previous buffer" })

-- Standard operations
map('n', ',zz', function() lazy.update() end, { desc = "Update lazy.nvim" })

-- Window, split, and buffer management (,w prefix)
map('n', ',wv', ':vsplit<CR>', { desc = "Split vertical" })
map('n', ',wh', ':split<CR>', { desc = "Split horizontal" })
map('n', ',wo', function() require('jil.bufremove').bufremove_others() end, { desc = "Close other windows" })
map('n', ',w=', '<C-w>=', { desc = "Equal width" })
map('n', ',wm', ':WindowsMaximize<CR>', { desc = "Maximize window" })
map('n', ',wd', function() require('jil.bufremove').bufremove() end, { desc = "Delete buffer" })
map('n', ',wl', function() telescope.buffers() end, { desc = "List buffers" })
map('n', ',wr', ':BufferRestore<CR>', { desc = "Restore last buffer" })

-- Diagnostics
map('n', ',dd', function() vim.diagnostic.open_float({ border = "rounded" }) end, { desc = "Line diagnostics" })
map('n', ',dw', function() telescope.diagnostics() end, { desc = "Workspace diagnostics" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
