return {
  {
    'lewis6991/gitsigns.nvim',
    version = "*",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "kylechui/nvim-surround",
    -- Load the plugin immediately since it provides keymaps
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
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
  },
  {
    'numToStr/Comment.nvim',
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set('n', 's', '<Plug>(leap)')
    end
  },
}
