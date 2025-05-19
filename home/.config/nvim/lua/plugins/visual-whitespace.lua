return {
  {
    'mcauley-penney/visual-whitespace.nvim',
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
    config = true,
    opts = {},
    enabled = function()
      local v = vim.version()
      return v.major > 0 or (v.major == 0 and v.minor >= 11)
    end,
    init = function()
      vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#44596E", bg = "#263C53" })
    end
  }
}
