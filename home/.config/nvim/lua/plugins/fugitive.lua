return {
  {
    'tpope/vim-fugitive',
    lazy = false, -- Load on startup since git integration is commonly needed
    config = function()
      -- Optional: Add your keymaps and configuration here
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
    end,
  }
}
