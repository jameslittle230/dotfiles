return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'EdenEast/nightfox.nvim' },
    config = function()
      require("lualine").setup({
        options = {
          section_separators = "",
          component_separators = ""
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'branch', icons_enabled = false }, 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'lsp_status', 'encoding', { 'filetype', icons_enabled = false } },
          lualine_y = { 'searchcount', 'progress' },
          lualine_z = { 'location' }
        },
      })
    end
  }
}
