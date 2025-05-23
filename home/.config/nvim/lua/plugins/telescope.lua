return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
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
          '--hidden',      -- search hidden files
          '--glob=!.git/*' -- but exclude .git directory
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
}
