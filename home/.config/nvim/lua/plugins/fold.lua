return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldcolumn = '1'
      vim.opt.fillchars = {
        eob = " ",
        fold = " ",
        foldopen = "▼",
        foldsep = " ",
        foldclose = "▶",
      }

      -- Only use treesitter and indent as fold providers
      require('ufo').setup({
        provider_selector = function()
          return { 'lsp', 'indent' }
        end

      })

      -- Basic keymaps
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
  }
}
