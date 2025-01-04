vim.opt.backspace = 'indent,eol,start' -- Allow backspace in insert mode
vim.opt.history = 1000                 -- Store lots of command line history
vim.opt.showcmd = true                 -- Show incomplete commands down the bottom
vim.opt.showmode = true                -- Show current mode down the bottom
vim.opt.visualbell = true              -- No sounds
vim.opt.autoread = true                -- Reload files changed outside vim
vim.opt.ruler = true                   -- Show ruler
vim.opt.undolevels = 1000              -- Undo levels
vim.opt.laststatus = 2                 -- Fix status bar

-- Some recommended modern settings
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors
vim.opt.scrolloff = 8             -- Keep 8 lines above/below cursor when scrolling
vim.opt.signcolumn = 'yes'        -- Always show sign column
vim.opt.updatetime = 50           -- Faster completion
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Search settings
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- Unless we type a capital

-- Indentation settings
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.softtabstop = 2   -- Number of spaces tabs count for in insert mode
vim.opt.autoindent = true -- Copy indent from current line when starting new line

-- Color column
vim.opt.colorcolumn = table.concat(vim.fn.range(81, 999), ',')
vim.opt.colorcolumn = "80," .. table.concat(vim.fn.range(120, 999), ',')
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#222833" })
  end
})

-- Markdown word wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true     -- Wrap at word boundaries
    vim.opt_local.textwidth = 0        -- Prevents hard wrapping
    vim.opt_local.wrapmargin = 0       -- Prevents automatic hard wrapping
  end
})
