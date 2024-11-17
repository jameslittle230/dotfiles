return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'EdenEast/nightfox.nvim' },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          section_separators = "",
          component_separators = ""
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { "require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      })
    end
  }
}
