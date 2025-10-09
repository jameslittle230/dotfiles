vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

vim.g.have_nerd_font = true

vim.opt.backspace = 'indent,eol,start' -- Allow backspace in insert mode
vim.opt.history = 1000                 -- Store lots of command line history
vim.opt.showcmd = true                 -- Show incomplete commands down the bottom
vim.opt.showmode = false               -- Don't show current mode at the bottom
vim.opt.visualbell = true              -- No sounds
vim.opt.autoread = true                -- Reload files changed outside vim
vim.opt.ruler = true                   -- Show ruler
vim.opt.undolevels = 1000              -- Undo levels
vim.opt.laststatus = 2                 -- Fix status bar

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor when scrolling
vim.opt.signcolumn = 'yes'    -- Always show sign column
vim.opt.updatetime = 50       -- Faster completion
vim.opt.mouse = 'a'           -- Enforce mouse mode enabled
vim.opt.confirm = true        -- Raise a dialog for ops that would fail with unsaved changes
vim.opt.inccommand = 'split'  -- Show preview split with live substitutions

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
end)

-- Search settings
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- Unless we type a capital

-- Indentation settings
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Size of an indent
vim.opt.softtabstop = 2    -- Number of spaces tabs count for in insert mode
vim.opt.autoindent = true  -- Copy indent from current line when starting new line
vim.opt.breakindent = true -- Wrapped lines stay visually indented on subsequent lines

-- Markdown word wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "txt", "plaintext", "" }, -- Empty string captures files with no filetype
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- Wrap at word boundaries
    vim.opt_local.textwidth = 0    -- Prevents hard wrapping
    vim.opt_local.wrapmargin = 0   -- Prevents automatic hard wrapping
  end
})
