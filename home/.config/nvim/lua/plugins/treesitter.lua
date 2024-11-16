return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (supported parsers can be found at https://tree-sitter.github.io/tree-sitter/)
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "rust",
          "go",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "bash",
          "vim",
          "help",
          "tsx",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },

        -- Optional: Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Optional: Enable text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      })

      -- Optional: Add a keymap to toggle playground
      vim.keymap.set('n', '<leader>tp', ':TSPlaygroundToggle<CR>', { desc = 'Toggle Treesitter Playground' })
    end,
  }
}
