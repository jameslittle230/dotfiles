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
  },


  {
    -- https://github.com/Chaitanyabsprip/fastaction.nvim
    -- Code action popup
    'Chaitanyabsprip/fastaction.nvim',
    opts = {
      dismiss_keys = { "j", "k", "<ESC>", "q" },
    }
  },


  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme('nightfox')
    end
  },
}
