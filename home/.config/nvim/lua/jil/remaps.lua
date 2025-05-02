local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  vim.keymap.set(mode, l, r, opts)
end

local telescope = require('telescope.builtin')
local nvimtree = require('nvim-tree.api')
local gitsigns = require('gitsigns')
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
map('n', 'K', vim.lsp.buf.hover, { desc = "Show hover" })
map('n', 'gcc', function() require('Comment.api').toggle.linewise.current() end, { desc = "Toggle comment" })

-- Enhanced operations
vim.keymap.set("n", "ycc", "yygccp", { remap = true })

-- Telescope/Search (,s prefix)
map('n', ',sf', function() telescope.find_files() end, { desc = "Search files" })
map('n', ',sg', function() telescope.live_grep() end, { desc = "Search text" })
map('n', ',sb', function() telescope.buffers() end, { desc = "Search buffers" })
map('n', ',sh', function() telescope.help_tags() end, { desc = "Search help" })
map('n', ',ss', function() telescope.lsp_document_symbols() end, { desc = "Search symbols" })
map('n', ',sr', function() telescope.lsp_references() end, { desc = "Search references" })
map('n', ',sc', function() telescope.git_commits() end, { desc = "Search commits" })
map('n', ',sd', function() telescope.diagnostics() end, { desc = "Search diagnostics" })
map('n', ',st', function() telescope.treesitter() end, { desc = "Search treesitter" })

-- File Tree (,e prefix)
map('n', ',ee', function() nvimtree.tree.toggle() end, { desc = "Toggle explorer" })
map('n', ',E', function() nvimtree.tree.focus() end, { desc = "Focus explorer" })
map('n', ',ef', function() nvimtree.tree.find_file() end, { desc = "Find file in explorer" })
map('n', ',ec', function() nvimtree.tree.collapse_all() end, { desc = "Collapse explorer" })
map('n', ',er', function() nvimtree.tree.reload() end, { desc = "Refresh explorer" })

-- LSP operations (,l prefix)
-- map('n', ',la', vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', ',la', '<cmd>lua require("fastaction").code_action()<CR>', { buffer = bufnr })
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
map('n', ',gl', function() telescope.git_commits() end, { desc = "List commits" })
map('n', ',gf', function() telescope.git_files() end, { desc = "Git files" })
map('n', ',gt', function() gitsigns.toggle_current_line_blame() end, { desc = "Toggle line blame" })
map('n', ',gx', function() gitsigns.toggle_deleted() end, { desc = "Toggle deleted" })

-- Treesitter (,t prefix)
map('n', ',ts', ':TSHighlightCapturesUnderCursor<CR>', { desc = "Show TS highlight" })
map('n', ',tp', ':TSPlaygroundToggle<CR>', { desc = "Toggle TS playground" })
map('n', ',ti', ':TSConfigInfo<CR>', { desc = "Show TS info" })
map('n', ',tu', ':TSUpdateSync<CR>', { desc = "Update TS parsers" })
map('n', ',tt', function() telescope.treesitter() end, { desc = "Search TS symbols" })

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
map('n', ',<space>f', function() telescope.find_files() end, { desc = "Find files" })
map('n', ',<space>g', function() telescope.live_grep() end, { desc = "Find text" })
map('n', ',<space>b', function() telescope.buffers() end, { desc = "Find buffer" })
map('n', ',<space>e', function() nvimtree.tree.toggle() end, { desc = "Toggle explorer" })
map('n', ',<space>d', function() telescope.diagnostics() end, { desc = "Search diagnostics" })
map('n', ',<space>s', function() telescope.lsp_document_symbols() end, { desc = "Search symbols" })
map('n', ',<space>v', function() lazy.update() end, { desc = "Update lazy.nvim" })

-- Diagnostics
map('n', ',dd', vim.diagnostic.open_float, { desc = "Line diagnostics" })
map('n', ',dw', function() telescope.diagnostics() end, { desc = "Workspace diagnostics" })

-- j/k
vim.keymap.set('n', 'k', function()
  return vim.v.count and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

vim.keymap.set('n', 'j', function()
  return vim.v.count and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })
