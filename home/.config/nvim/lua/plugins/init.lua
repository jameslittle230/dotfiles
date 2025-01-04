return {
  {
    'lewis6991/gitsigns.nvim',
    version = "*",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme('nightfox')
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        fast_wrap = {
          map = '<C-e>'
        }
      })
    end
  },
  { 'numToStr/Comment.nvim', },
  { "ggandor/leap.nvim",     event = "VeryLazy" },
  { "chentoast/marks.nvim",  event = "VeryLazy", opts = {} },
  {
    'echasnovski/mini.tabline',
    version = '*',
    config = function()
      require('mini.tabline').setup()
    end
  },
}
