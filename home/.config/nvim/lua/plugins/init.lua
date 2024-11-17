return {
  {
    'lewis6991/gitsigns.nvim',
    version = "*",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "tpope/vim-surround",
    -- Load the plugin immediately since it provides keymaps
    event = "VeryLazy",
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        style = 'cool',
      })
      vim.cmd.colorscheme('nightfox')
    end
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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
