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
        -- a list of parser names, or "all" (supported parsers can be found at https://tree-sitter.github.io/tree-sitter/)
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "rust",
          "ruby",
          "go",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "bash",
          "vim",
          "tsx",
          "toml"
        },

        ignore_install = { "help" },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          -- setting this to true will run `:h syntax` and tree-sitter at the same time.
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },

        -- optional: enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "vv", -- set to `false` to disable one of the mappings
            node_incremental = ">",
            scope_incremental = false,
            node_decremental = "<",
          },
        },

        -- optional: enable text objects
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "next function call start" },
              ["]m"] = { query = "@function.outer", desc = "next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "next loop start" },

              -- you can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- below example nvim-treesitter's `locals.scm` and `folds.scm`. they also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "next fold" },
            },
            goto_next_end = {
              ["]f"] = { query = "@call.outer", desc = "next function call end" },
              ["]m"] = { query = "@function.outer", desc = "next method/function def end" },
              ["]c"] = { query = "@class.outer", desc = "next class end" },
              ["]i"] = { query = "@conditional.outer", desc = "next conditional end" },
              ["]l"] = { query = "@loop.outer", desc = "next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "prev loop start" },
            },
            goto_previous_end = {
              ["[f"] = { query = "@call.outer", desc = "prev function call end" },
              ["[m"] = { query = "@function.outer", desc = "prev method/function def end" },
              ["[c"] = { query = "@class.outer", desc = "prev class end" },
              ["[i"] = { query = "@conditional.outer", desc = "prev conditional end" },
              ["[l"] = { query = "@loop.outer", desc = "prev loop end" },
            },
          },

          swap = {
            enable = true,
            swap_next = {
              ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
              ["<leader>nm"] = "@function.outer",  -- swap function with next
            },
            swap_previous = {
              ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
              ["<leader>pm"] = "@function.outer",  -- swap function with previous
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- you can use the capture groups defined in textobjects.scm
              ["a="] = { query = "@assignment.outer", desc = "select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "select right hand side of an assignment" },

              ["aa"] = { query = "@parameter.outer", desc = "select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "select inner part of a class" },
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
    end,
  }
}
