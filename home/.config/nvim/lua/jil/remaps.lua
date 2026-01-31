local default_opts = { noremap = true, silent = true }

local function map(mode, l, r, opts)
  opts = opts or default_opts
  if type(opts) == "string" then
    opts = { desc = opts }
  end
  vim.keymap.set(mode, l, r, opts)
end

map('i', 'jk', '<Esc>')
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "j", "gj")
map("n", "k", "gk")

map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map("n", "<C-S-j>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-k>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", '[p', '<Cmd>exe "put! " . v:register<CR>', 'Paste Above')
map("n", ']p', '<Cmd>exe "put "  . v:register<CR>', 'Paste Below')

map("n", ",s", "<Cmd>Telescope<CR>", "Telescope")
map("n", ",sf", "<Cmd>Telescope find_files<CR>", "Find files")
map("n", ",sg", "<Cmd>Telescope live_grep<CR>", "Live grep")
map("n", ",sb", "<Cmd>Telescope buffers<CR>", "Find buffers")
map("n", ",ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "Open file picker")
map("n", ",?", '<Cmd>lua require("which-key").show({ global = true })<CR>', "Open which-key")

map("n", ",bd", "<Cmd>bd<CR>", "Delete buffer")
map("n", ",bo", "<Cmd>%bd|e#|bd#<CR>", "Delete other buffers")

map('n', ',wv', ':vsplit<CR>', "Split vertical")
map('n', ',wh', ':split<CR>', "Split horizontal")
map('n', ',w=', '<C-w>=', { desc = "Equal width" })

map('n', ',gs', function() require('gitsigns').stage_hunk() end, "Stage hunk")
map('n', ',gr', function() require('gitsigns').reset_hunk() end, "Reset hunk")
map('n', ',gS', function() require('gitsigns').stage_buffer() end, "Stage buffer")
map('n', ',gR', function() require('gitsigns').reset_buffer() end, "Reset buffer")
map('n', ',gb', function() require('gitsigns').blame_line() end, "Blame line")
map('n', ',gp', function() require('gitsigns').preview_hunk() end, "Preview hunk")
map('n', ',gd', function() require('gitsigns').diffthis() end, "Diff this")
map('n', ',gB', function() require('gitsigns').blame_line({ full = true }) end, "Blame line full")
map('n', ',gt', function() require('gitsigns').toggle_current_line_blame() end, "Toggle line blame")
map('n', ',gx', function() require('gitsigns').toggle_deleted() end, "Toggle deleted")

map('n', ",sd", "", "LSP Definitions")
map('n', ",sr", function() require('telescope.builtin').lsp_references() end, "LSP References")
map('n', ',lr', vim.lsp.buf.rename, "Rename symbol")
map('n', ',la', function() require('fastaction').code_action() end, "Code actions")
map('n', ',dd', function() vim.diagnostic.open_float({ border = "rounded" }) end, "Show diagnostics")
map('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, "Show hover information")

map('n', 'gd', vim.lsp.buf.definition, "Go to definition")
map('n', 'gr', vim.lsp.buf.references, "Go to references")
map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
map('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
map('n', 'gt', vim.lsp.buf.type_definition, "Go to type definition")

map('n', ',zz', '<Cmd>Lazy update<CR>', "Update lazy.nvim")

map('n', ',dt', function() require("snacks").dim() end, "Toggle dim")
