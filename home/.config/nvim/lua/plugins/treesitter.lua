return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.install({
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
      })

      require('nvim-treesitter-textobjects').setup()

      -- Move: jump between functions and classes
      local move = require('nvim-treesitter-textobjects.move')
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer') end, opts)
      map({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer') end, opts)
      map({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer') end, opts)
      map({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer') end, opts)
      map({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer') end, opts)
      map({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer') end, opts)
      map({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer') end, opts)
      map({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer') end, opts)

      -- Swap: reorder parameters
      local swap = require('nvim-treesitter-textobjects.swap')
      map('n', ',a', function() swap.swap_next('@parameter.inner') end, opts)
      map('n', ',A', function() swap.swap_previous('@parameter.inner') end, opts)

      -- Treesitter context
      require('treesitter-context').setup({
        max_lines = 3,
        trim_scope = 'outer',
      })
    end,
  }
}
