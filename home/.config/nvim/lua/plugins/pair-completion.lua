return {
  {
    -- https://github.com/kylechui/nvim-surround
    -- ys/ds/cs to add, delete, or change surrounds
    'kylechui/nvim-surround',
    event = "VeryLazy", -- Load the plugin immediately since it provides keymaps
    opts = {}
  },


  {
    -- https://github.com/windwp/nvim-autopairs
    -- Automatically add }, for example, when I type {
    -- opt-e for fast-wrap
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = { fast_wrap = {} }
  },


  {
    -- https://github.com/windwp/nvim-ts-autotag
    -- Autoclose and autorename HTML tags
    "windwp/nvim-ts-autotag",
    lazy = false,
    opts = {
      opts = {
        enable_close_on_slash = true
      }
    }
  },


  {
    -- https://github.com/RRethy/nvim-treesitter-endwise
    -- In Ruby, add `end` keyword in useful situations
    'RRethy/nvim-treesitter-endwise',
  },
}
