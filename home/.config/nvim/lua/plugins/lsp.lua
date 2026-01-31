return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      cmdline = { enabled = false },
      keymap = { preset = "enter" },
      completion = {
        keyword = { range = 'full' },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
        documentation = { window = { border = 'single' } },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", gap = 1 },
              { "kind" }
            }
          }
        }
      }
    }
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "ts_ls",
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        lua = { "stylua" },
        python = { "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat for yaml
        local filetype = vim.bo[bufnr].filetype
        if filetype == 'yaml' or filetype == 'yml' then
          return
        end

        return {
          timeout_ms = 500,
          lsp_fallback = true, -- Uses LSP if no conform formatter configured
        }
      end,
    },
  }
}
