return { {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    { ',sf', function() require('telescope.builtin').find_files() end, desc = "Search files" },
    { ',sg', function() require('telescope.builtin').live_grep() end, desc = "Search text" },
    { ',sb', function() require('telescope.builtin').buffers() end, desc = "Search buffers" },
    { ',sh', function() require('telescope.builtin').help_tags() end, desc = "Search help" },
    { ',sr', function() require('telescope.builtin').lsp_references() end, desc = "Search references" },
    { ',sc', function() require('telescope.builtin').git_commits() end, desc = "Search commits" },
    { ',sd', function() require('telescope.builtin').diagnostics() end, desc = "Search diagnostics" },
    { ',st', function() require('telescope.builtin').treesitter() end, desc = "Search treesitter" },
    { ',sq', function() require('telescope.builtin').quickfix() end, desc = "Search quickfix" },
    { ',sm', function() require('telescope.builtin').marks() end, desc = "Search marks" },
    { ',ss', function() require('telescope.builtin').resume() end, desc = "Resume most recent quickfix" },
    { ',su', "<cmd>Telescope undo<cr>", desc = "Search undos" },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        preview = {
          filesize_limit = 0.1,
        },
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

        file_ignore_patterns = { "node_modules/", ".git/", "dist/", "build/", "%.lock" },

        -- Improve find_files to use ripgrep if available
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
        },

        -- Make path display shorter
        path_display = { "truncate" },

        extensions = { undo = {} }
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
    require('telescope').load_extension("undo")
  end
},
  {

  }
}
