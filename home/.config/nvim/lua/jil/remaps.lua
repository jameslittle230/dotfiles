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

map("n", '[p', '<Cmd>exe "put! " . v:register<CR>', 'Paste Above')
map("n", ']p', '<Cmd>exe "put "  . v:register<CR>', 'Paste Below')

map("n", ",s", "<Cmd>Telescope<CR>", "Telescope")
map("n", ",sf", "<Cmd>Telescope find_files<CR>", "Find files")
map("n", ",sb", "<Cmd>Telescope buffers<CR>", "Find buffers")
map("n", ",ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "Open file picker")
map("n", ",?", '<Cmd>lua require("which-key").show({ global = true })<CR>', "Open which-key")

map("n", ",bd", "<Cmd>bd<CR>", "Delete buffer")

map('n', ',wv', ':vsplit<CR>', "Split vertical")
map('n', ',wh', ':split<CR>', "Split horizontal")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", "Next Search Result")
map("x", "n", "'Nn'[v:searchforward]", "Next Search Result")
map("o", "n", "'Nn'[v:searchforward]", "Next Search Result")
map("n", "N", "'nN'[v:searchforward].'zv'", "Prev Search Result")
map("x", "N", "'nN'[v:searchforward]", "Prev Search Result")
map("o", "N", "'nN'[v:searchforward]", "Prev Search Result")

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

map('n', ",sd", function() require('telescope.builtin').lsp_definitions() end, "LSP Definitions")
map('n', ",sr", function() require('telescope.builtin').lsp_references() end, "LSP References")
map('n', ',lr', vim.lsp.buf.rename, "Rename symbol")
map('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, "Show hover information")
