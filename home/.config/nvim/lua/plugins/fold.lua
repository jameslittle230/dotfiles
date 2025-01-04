return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'luukvbaal/statuscol.nvim',
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

      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { "%s" },                       click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc },           click = "v:lua.ScLa", },
          { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        }
      })
    end
  }
}
