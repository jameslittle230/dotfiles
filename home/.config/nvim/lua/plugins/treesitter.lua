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
        'lua',
        'python',
        'vim',
        'vimdoc',
      })
    end,
  }
}
