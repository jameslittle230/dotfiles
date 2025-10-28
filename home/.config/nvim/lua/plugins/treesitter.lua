return {
  {
    -- https://github.com/Wansmer/treesj
    -- ,tm to toggle split/join blocks of code across multiple lines
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { ',tm', function() require('treesj').toggle() end, desc = "Toggle split/join" },
    }
  },


  {
    -- https://github.com/aaronik/treewalker.nvim
    -- Move around your code in a syntax tree aware manner
    -- Ctrl-HJKL or Ctrl-Shift-HJKL to navigate or move treesitter hunks
    'aaronik/treewalker.nvim',

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = 'CursorLine',
    },
    keys = {
      { '<A-k>', '<cmd>Treewalker Up<cr>', mode = { 'n', 'v' }, silent = true },
      { '<A-j>', '<cmd>Treewalker Down<cr>', mode = { 'n', 'v' }, silent = true },
      { '<A-h>', '<cmd>Treewalker Left<cr>', mode = { 'n', 'v' }, silent = true },
      { '<A-l>', '<cmd>Treewalker Right<cr>', mode = { 'n', 'v' }, silent = true },
      { '<A-S-k>', '<cmd>Treewalker SwapUp<cr>', silent = true },
      { '<A-S-j>', '<cmd>Treewalker SwapDown<cr>', silent = true },
      { '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>', silent = true },
      { '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', silent = true },
    }
  },

  {
    'glts/vim-textobj-comment',
    dependencies = { 'kana/vim-textobj-user' },
    lazy = false,
  },

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
          "vimdoc",
          "tsx",
          "ruby",
          "toml"
        },

        ignore_install = { "help" },
        sync_install = false,
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
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },

        -- Optional: Enable text objects
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "next function call start" },
              ["]m"] = { query = "@function.outer", desc = "next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "next loop start" },
              ["]s"] = { query = "@scope", query_group = "locals", desc = "next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "next fold" },
              ["]/"] = { query = "@comment", query_group = "comments", desc = "next comment" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "next function call end" },
              ["]M"] = { query = "@function.outer", desc = "next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "prev loop start" },
              ["[/"] = { query = "@comment", query_group = "comments", desc = "prev comment" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "prev loop end" },
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

              ["ac"] = { query = "@comment.outer", desc = "select outer part of a comment" },
              ["ic"] = { query = "@comment.inner", desc = "select inner part of a comment" },

              ["ai"] = { query = "@conditional.outer", desc = "select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "select inner part of a method/function definition" },
            },
          },
        },
      })
    end,
  },
}
