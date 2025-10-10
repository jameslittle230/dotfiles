return {
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    -- Shows git status in left rail, but also includes lots of other Git functionality
    'lewis6991/gitsigns.nvim',
    opts = { current_line_blame = true }
  },


  {
    'tpope/vim-fugitive',
    lazy = false, -- Load on startup since git integration is commonly needed
  }
}
