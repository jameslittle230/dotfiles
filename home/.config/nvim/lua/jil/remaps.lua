local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  vim.keymap.set(mode, l, r, opts)
end

local telescope = require('telescope.builtin')
local gitsigns = require('gitsigns')
local lazy = require('lazy')
local fastaction = require("fastaction")
local marks = require('marks')

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
map('n', ']g', function() gitsigns.next_hunk() end, { desc = "Next git hunk" })
map('n', '[g', function() gitsigns.prev_hunk() end, { desc = "Previous git hunk" })
map('n', ']b', ':bnext<CR>', { desc = "Next buffer" })
map('n', '[b', ':bprevious<CR>', { desc = "Previous buffer" })

-- LSP Go-to
map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
map('n', 'gr', vim.lsp.buf.references, { desc = "Go to references" })
map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
map('n', 'gt', vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Standard operations
map('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Show hover" })
map('n', ',zz', function() lazy.update() end, { desc = "Update lazy.nvim" })

-- Marks
map('n', ',md', marks.toggle, { desc = "Toggle mark" })
map('n', ',mp', marks.preview, { desc = "Preview mark" })

-- Telescope/Search (,s prefix)
map('n', ',sf', function() telescope.find_files() end, { desc = "Search files" })
map('n', ',sg', function() telescope.live_grep() end, { desc = "Search text" })
map('n', ',sb', function() telescope.buffers() end, { desc = "Search buffers" })
map('n', ',sh', function() telescope.help_tags() end, { desc = "Search help" })
map('n', ',sr', function() telescope.lsp_references() end, { desc = "Search references" })
map('n', ',sc', function() telescope.git_commits() end, { desc = "Search commits" })
map('n', ',sd', function() telescope.diagnostics() end, { desc = "Search diagnostics" })
map('n', ',st', function() telescope.treesitter() end, { desc = "Search treesitter" })
map('n', ',sq', function() telescope.quickfix() end, { desc = "Search quickfix" })
map('n', ',sm', function() telescope.marks() end, { desc = "Search marks" })
map('n', ',ss', function() telescope.resume() end, { desc = "Resume most recent quickfix" })
map('n', ',su', "<cmd>Telescope undo<cr>", { desc = "Search undos" })

-- File Tree (,e prefix)
map('n', ',ee', ":Neotree show toggle<CR>", { desc = "Toggle explorer" })
map('n', ',ef', ":Neotree focus reveal<CR>", { desc = "Focus explorer" })

-- LSP operations (,l prefix)
map('n', ',la', function() fastaction.code_action() end, { desc = "Code actions" })
map('n', ',lr', vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', ',lf', function() vim.lsp.buf.format({ async = true }) end, { desc = "Format code" })
map('n', ',ll', vim.lsp.codelens.run, { desc = "Run codelens" })
map('n', ',lR', ':LspRestart<CR>', { desc = "Restart LSP" })
map('n', ',li', ':LspInfo<CR>', { desc = "LSP info" })
map('n', ',ld', function() telescope.lsp_definitions() end, { desc = "Search definitions" })
map('n', ',lt', function() telescope.lsp_type_definitions() end, { desc = "Search type definitions" })

-- Git operations (,g prefix)
map('n', ',gs', function() gitsigns.stage_hunk() end, { desc = "Stage hunk" })
map('n', ',gr', function() gitsigns.reset_hunk() end, { desc = "Reset hunk" })
map('n', ',gS', function() gitsigns.stage_buffer() end, { desc = "Stage buffer" })
map('n', ',gR', function() gitsigns.reset_buffer() end, { desc = "Reset buffer" })
map('n', ',gb', function() gitsigns.blame_line() end, { desc = "Blame line" })
map('n', ',gp', function() gitsigns.preview_hunk() end, { desc = "Preview hunk" })
map('n', ',gd', function() gitsigns.diffthis() end, { desc = "Diff this" })
map('n', ',gB', function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line full" })
map('n', ',gt', function() gitsigns.toggle_current_line_blame() end, { desc = "Toggle line blame" })
map('n', ',gx', function() gitsigns.toggle_deleted() end, { desc = "Toggle deleted" })

-- Treesitter (,t prefix)
map('n', ',tm', require('treesj').toggle, { desc = "Toggle split/join" })

-- Treewalker
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<cmd>Treewalker Right<cr>', { silent = true })
vim.keymap.set('n', '<A-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<A-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
vim.keymap.set('n', '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true })

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
