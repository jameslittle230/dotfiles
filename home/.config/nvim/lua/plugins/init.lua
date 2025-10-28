return {
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
  },


  {
    -- https://github.com/chentoast/marks.nvim
    -- Shows marks in sign column.
    -- dmx to delete mark x, m; to toggle next alphabetical mark
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { ',md', function() require('marks').toggle() end, desc = "Toggle mark" },
      { ',mp', function() require('marks').preview() end, desc = "Preview mark" },
    }
  },


  {
    -- https://github.com/Chaitanyabsprip/fastaction.nvim
    -- Code action popup
    'Chaitanyabsprip/fastaction.nvim',
    opts = {
      dismiss_keys = { "j", "k", "<ESC>", "q" },
    },
    keys = {
      { ',la', function() require('fastaction').code_action() end, desc = "Code actions" },
    }
  },


  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme('nightfox')
    end
  },
}
