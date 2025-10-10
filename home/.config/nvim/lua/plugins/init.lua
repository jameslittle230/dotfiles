return {
  { 'lewis6991/gitsigns.nvim', },
  { "ggandor/leap.nvim",               event = "VeryLazy" },
  { "chentoast/marks.nvim",            event = "VeryLazy", },
  { 'echasnovski/mini.tabline',        lazy = false },
  { 'Chaitanyabsprip/fastaction.nvim', opts = {}, },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme('nightfox')
    end
  },
}
