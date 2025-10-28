return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { ',ee', ":Neotree show toggle<CR>", desc = "Toggle explorer" },
      { ',ef', ":Neotree focus reveal<CR>", desc = "Focus explorer" },
    },
    opts = {
      close_if_last_window = true,
      window = {
        position = "right"
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          visible = true,
          never_show = { ".git" },
          always_show_by_pattern = { ".env*" },
        }
      },
    },
  }
}
