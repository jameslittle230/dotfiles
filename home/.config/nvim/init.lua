-- Reload neovim config when this file changes
vim.cmd([[
  augroup AutoReloadConfig
    autocmd!
    autocmd BufWritePost ~/Code/dotfiles/home/.config/nvim/init.lua execute '!cd ~/Code/dotfiles && ./init.sh' | execute 'source ~/.config/nvim/init.lua' | echom "Ran init.sh and reloaded config"

  augroup END
]])
-- General settings
vim.opt.backspace = 'indent,eol,start'  -- Allow backspace in insert mode
vim.opt.history = 1000                  -- Store lots of command line history
vim.opt.showcmd = true                  -- Show incomplete commands down the bottom
vim.opt.showmode = true                 -- Show current mode down the bottom
vim.opt.guicursor = 'a:blinkon0'        -- Disable cursor blink
vim.opt.visualbell = true               -- No sounds
vim.opt.autoread = true                 -- Reload files changed outside vim
vim.opt.ruler = true                    -- Show ruler
vim.opt.undolevels = 1000               -- Undo levels
vim.opt.laststatus = 2                  -- Fix status bar

-- Some recommended modern settings
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.termguicolors = true            -- Enable 24-bit RGB colors
vim.opt.scrolloff = 8                   -- Keep 8 lines above/below cursor when scrolling
vim.opt.signcolumn = 'yes'              -- Always show sign column
vim.opt.updatetime = 50                 -- Faster completion
vim.opt.clipboard = 'unnamedplus'       -- Use system clipboard

-- Search settings
vim.opt.ignorecase = true              -- Ignore case when searching
vim.opt.smartcase = true               -- Unless we type a capital

-- Indentation settings
vim.opt.expandtab = true               -- Use spaces instead of tabs
vim.opt.shiftwidth = 2                 -- Size of an indent
vim.opt.softtabstop = 2                -- Number of spaces tabs count for in insert mode
vim.opt.autoindent = true              -- Copy indent from current line when starting new line

-- Remaps
vim.g.mapleader = ','
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, desc = 'Exit insert mode with jk' })
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- nvim-tree keybindings
-- Main toggles
map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<Leader>fe', ':NvimTreeFocus<CR>', opts)

-- File operations in nvim-tree
map('n', '<Leader>fr', ':NvimTreeRefresh<CR>', opts)
map('n', '<Leader>fn', ':NvimTreeFindFile<CR>', opts)  -- Find current file in tree

-- Telescope keybindings
-- File pickers
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<Leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<Leader>fh', ':Telescope help_tags<CR>', opts)

-- Git pickers
map('n', '<Leader>gc', ':Telescope git_commits<CR>', opts)
map('n', '<Leader>gb', ':Telescope git_branches<CR>', opts)
map('n', '<Leader>gs', ':Telescope git_status<CR>', opts)







-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
    },
    {
      'lewis6991/gitsigns.nvim',
      version = "*",
      config = function()
        require('gitsigns').setup()
      end
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {
          sort_by = "case_sensitive",
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
          },
          on_attach = "default",
          hijack_directories = {
            enable = true,
            auto_open = true,
          },
        }
      end,
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('telescope').setup({  
          defaults = {
           -- Enable recursive search by default
            vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--hidden',  -- search hidden files
              '--glob=!.git/*'  -- but exclude .git directory
            },
            
            file_ignore_patterns = {
              "node_modules/",
              ".git/",
              "dist/",
              "build/",
              "%.lock"
            },

            -- Improve find_files to use ripgrep if available
            find_files = {
              find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
            },

            -- Make path display shorter
            path_display = { "truncate" },
          },
          pickers = {
            find_files = {
              -- Tells telescope to search hidden files by default
              hidden = true,
              -- Use ripgrep if available (much faster)
              find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
            },
            live_grep = {
              -- Additional arguments for live grep
              additional_args = function()
                return { '--hidden' }
              end
            }
          },
        })
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
          })
      end
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.api.nvim_create_autocmd({"VimEnter"}, {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if directory then
      -- change to the directory
      vim.cmd.cd(data.file)
      -- open the tree
      require("nvim-tree.api").tree.open()
    end
  end
})

vim.cmd.colorscheme("default")
