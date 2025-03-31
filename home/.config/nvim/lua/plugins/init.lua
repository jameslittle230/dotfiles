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
  { "ggandor/leap.nvim",          event = "VeryLazy" },
  { "tronikelis/ts-autotag.nvim", opts = {} },
  { "chentoast/marks.nvim",       event = "VeryLazy", opts = {} },
  { 'echasnovski/mini.tabline',   lazy = false,       opts = {} },

  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade",
      render = "minimal",
      top_down = false,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}
