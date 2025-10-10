return {
  {
    -- https://github.com/numToStr/Comment.nvim
    -- Adds keybindings for quickly commenting lines, blocks, or text objects
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },


  {
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    -- Fixes comment toggling behavior for files with multiple comment styles
    -- within the same file (like TSX files)
    'JoosepAlviste/nvim-ts-context-commentstring'
  },


  {
    -- https://github.com/andrewferrier/debugprint.nvim
    -- Adds shortcuts for quickly adding debug print lines
    "andrewferrier/debugprint.nvim",
    opts = {
      display_location = true,
      display_counter = false,
      notify_for_registers = false,
      highlight_lines = false,
      print_tag = "JIL-LOG"
    },
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Optional: If you want to use the :SearchDebugPrints command with telescope.nvim
    },
    lazy = false,                      -- Required to make line highlighting work before debugprint is first used
    version = "*",                     -- Remove if you DON'T want to use the stable version
  }
}
