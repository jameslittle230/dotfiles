return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
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
