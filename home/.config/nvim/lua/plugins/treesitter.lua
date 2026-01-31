return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context"
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
    end,
  }
}
