require("jil")

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
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    {
      'numToStr/Comment.nvim',
      opts = {
          -- add any options here
      }
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

-- Function to create a floating terminal
local function open_floating_terminal()
    -- Get editor dimensions
    local columns = vim.o.columns
    local lines = vim.o.lines
    
    -- Calculate floating window size
    local width = math.floor(columns * 0.6)
    local height = math.floor(lines * 0.6)
    
    -- Calculate starting position
    local col = math.floor((columns - width) / 2)
    local row = math.floor((lines - height) / 2)
    
    -- Set window options
    local opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded'
    }
    
    -- Create buffer and window
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- Open terminal in the buffer
    vim.cmd('terminal')
    vim.cmd('startinsert')
end

-- Set up the keybinding (Ctrl+t)
vim.keymap.set('n', '<C-t>', open_floating_terminal, { noremap = true, silent = true })

-- Optional: Easy escape from terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
