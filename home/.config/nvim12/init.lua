vim.g.mapleader = "," -- set leader key to comma
vim.g.maplocalleader = "," -- set local leader key to comma

vim.g.loaded_netrw = 1 -- disable built-in file explorer netrw
vim.g.loaded_netrwPlugin = 1 -- disable netrw plugin
vim.o.autoread = true -- reload files changed outside of neovim
vim.o.breakindent = true -- wrapped lines continue visually indented
vim.o.clipboard = "unnamedplus" -- use system clipboard for yank/paste
vim.o.cursorline = true -- highlight the line the cursor is on
vim.o.expandtab = true -- insert spaces instead of tabs
vim.o.history = 1000 -- number of commands to keep in history
vim.o.hlsearch = true -- highlight all search matches
vim.o.ignorecase = true -- ignore case when searching
vim.o.inccommand = "split" -- preview substitutions live in a split
vim.o.laststatus = 2 -- always show the status line
vim.o.list = true -- show invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- symbols for invisible characters
vim.o.mouse = "a" -- enable mouse support in all modes
vim.o.number = true -- show absolute line numbers
vim.o.relativenumber = true -- show relative line numbers
vim.o.ruler = true -- show cursor position in status line
vim.o.scrolloff = 8 -- keep 8 lines visible above/below cursor
vim.o.shiftwidth = 2 -- spaces to use for each indent step
vim.o.showcmd = true -- show partial command in status line
vim.o.showmode = false -- don't show mode (e.g. -- INSERT --) in command line
vim.o.signcolumn = "yes" -- always show the sign column (prevents layout shift)
vim.o.smartcase = true -- case-sensitive search if pattern has uppercase
vim.o.splitbelow = true -- new horizontal splits open below
vim.o.splitright = true -- new vertical splits open to the right
vim.o.tabstop = 2 -- number of spaces a tab character counts for
vim.o.textwidth = 80 -- wrap text at 80 characters
vim.o.undofile = true -- persist undo history across sessions
vim.o.undolevels = 1000 -- maximum number of undo steps
vim.o.updatetime = 50 -- ms of inactivity before writing swap file (affects CursorHold)
vim.o.wrap = true -- wrap long lines visually
vim.o.winborder = "rounded"

vim.api.nvim_create_augroup("ReloadConfig", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "ReloadConfig",
  pattern = vim.fn.expand("~/.config/nvim12") .. "/*",
  callback = function()
    dofile(vim.fn.expand("~/.config/nvim12/init.lua"))
    vim.notify("Reloaded")
  end,
})

local default_opts = { noremap = true, silent = true }
local function map(mode, l, r, opts)
  opts = opts or default_opts
  if type(opts) == "string" then
    opts = { desc = opts }
  end
  vim.keymap.set(mode, l, r, opts)
end

map("i", "jk", "<Esc>") -- exit insert mode with jk
map("v", "<", "<gv") -- stay in visual mode after dedenting
map("v", ">", ">gv") -- stay in visual mode after indenting
map("n", "j", "gj") -- move down by visual line (respects wrap)
map("n", "k", "gk") -- move up by visual line (respects wrap)

map("n", "<C-j>", "<C-w>j") -- move to split below
map("n", "<C-k>", "<C-w>k") -- move to split above
map("n", "<C-h>", "<C-w>h") -- move to split left
map("n", "<C-l>", "<C-w>l") -- move to split right

map("n", "<C-S-j>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-k>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "[p", '<Cmd>exe "put! " . v:register<CR>', "Paste Above")
map("n", "]p", '<Cmd>exe "put "  . v:register<CR>', "Paste Below")

map("n", ",wv", ":vsplit<CR>", "Split vertical")
map("n", ",wh", ":split<CR>", "Split horizontal")
map("n", ",w=", "<C-w>=", { desc = "Equal width" })
map("n", ",wc", "<C-w>c", "Close split")

map("n", ",bd", "<Cmd>bd<CR>", "Delete buffer")
map("n", ",bo", "<Cmd>%bd|e#|bd#<CR>", "Delete other buffers")

vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" }, { confirm = false })
require("nightfox").setup({ options = { styles = { comments = "italic" } } })
vim.cmd.colorscheme("nightfox")

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })
require("blink.cmp").setup({
  cmdline = { enabled = false },
  keymap = { preset = "enter" },
  fuzzy = { implementation = "lua" },
  completion = {
    keyword = { range = "full" },
    list = { selection = { preselect = false, auto_insert = true } },
    ghost_text = { enabled = true },
    documentation = { window = { border = "single" } },
    menu = {
      border = "single",
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
  },
})

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim", -- library dependency
  "https://github.com/nvim-tree/nvim-web-devicons", -- icons (nerd font)
  "https://github.com/nvim-telescope/telescope.nvim", -- the fuzzy finder
}, { confirm = false })

require("telescope").setup({
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    live_grep = { additional_args = { "--hidden" } },
  },
})

map("n", ",s", "<Cmd>Telescope<CR>", "Telescope")
map("n", ",sf", "<Cmd>Telescope find_files<CR>", "Find files")
map("n", ",sg", "<Cmd>Telescope live_grep<CR>", "Live grep")
map("n", ",sb", "<Cmd>Telescope buffers<CR>", "Find buffers")
map("n", ",sr", "<Cmd>Telescope resume<CR>", "Resume last search")
map("n", ",ss", "<Cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
map("n", ",sS", "<Cmd>Telescope lsp_workspace_symbols<CR>", "Workspace symbols")

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
  options = {
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "branch", icons_enabled = false }, "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      { "lsp_status", ignore_lsp = { "null-ls" } },
      { "filetype", icons_enabled = false },
    },
    lualine_y = { "searchcount", "progress" },
    lualine_z = { "location" },
  },
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.pack.add({
  "https://github.com/nvim-mini/mini.tabline",
  "https://github.com/nvim-mini/mini.notify",
  "https://github.com/nvim-mini/mini.splitjoin",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/tpope/vim-fugitive",
})

vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup({
  spec = {
    { ",s", group = "Search" },
    { ",w", group = "Window" },
    { ",b", group = "Buffer" },
    { ",g", group = "Git" },
    { ",l", group = "LSP" },
    { ",d", group = "Diagnostics" },
    { ",e", group = "Explorer" },
  },
})

vim.pack.add({ "https://github.com/nvim-mini/mini.files" })
require("mini.files").setup({})
map("n", ",ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "Open file picker")

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({})
map("n", ",gs", "<Cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
map("n", ",gr", "<Cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
map("n", ",gS", "<Cmd>Gitsigns stage_buffer<CR>", "Stage buffer")
map("n", ",gR", "<Cmd>Gitsigns reset_buffer<CR>", "Reset buffer")
map("n", ",gb", "<Cmd>Gitsigns blame_line<CR>", "Blame line")
map("n", ",gp", "<Cmd>Gitsigns preview_hunk<CR>", "Preview hunk")
map("n", ",gd", "<Cmd>Gitsigns diffthis<CR>", "Diff this")
map("n", ",gB", "<Cmd>Gitsigns blame_line full=true<CR>", "Blame line full")
map("n", ",gt", "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle line blame")
map("n", ",gx", "<Cmd>Gitsigns preview_hunk_inline<CR>", "Toggle deleted")

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  formatters = {
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--column-width", "120" },
    },
  },
  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype
    if filetype == "yaml" or filetype == "yml" then
      return
    end

    return {
      timeout_ms = 500,
      lsp_fallback = true, -- Uses LSP if no conform formatter configured
    }
  end,
})

local lsp_servers = {
  lua_ls = {
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } },
  },
  clangd = {},
  rust_analyzer = {},
  ts_ls = {},
}

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
  "https://github.com/mason-org/mason.nvim", -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, { settings = config })
end

map("n", ",lr", vim.lsp.buf.rename, "Rename symbol")
map("n", ",la", vim.lsp.buf.code_action, "Code actions")
map("n", ",dd", vim.diagnostic.open_float, "Show diagnostics")
map("n", "K", vim.lsp.buf.hover, "Show hover information")
map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gr", vim.lsp.buf.references, "Go to references")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
