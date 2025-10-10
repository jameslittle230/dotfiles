return {
  {
    'kylechui/nvim-surround',
    event = "VeryLazy", -- Load the plugin immediately since it provides keymaps
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = { fast_wrap = {} }
  },
  {
    "tronikelis/ts-autotag.nvim",
    lazy = false,
    opts = {
      enable_close_on_slash = true
    }
  },
  { 'RRethy/nvim-treesitter-endwise' },
}
