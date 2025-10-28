return {
  { 'williamboman/mason.nvim', lazy = false, opts = {} },

  -- Autocompletion
  {
    -- https://cmp.saghen.dev/installation
    "saghen/blink.cmp",
    version = "1.*", -- release tag to download prebuilt binary
    opts = {
      keymap = { preset = "enter" },
      completion = { documentation = { auto_show = true } },
    }
  },

  -- LSP
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'nvimtools/none-ls.nvim' }
    },
    keys = {
      -- LSP Go-to
      { 'gd', vim.lsp.buf.definition, desc = "Go to definition" },
      { 'gr', vim.lsp.buf.references, desc = "Go to references" },
      { 'gD', vim.lsp.buf.declaration, desc = "Go to declaration" },
      { 'gi', vim.lsp.buf.implementation, desc = "Go to implementation" },
      { 'gt', vim.lsp.buf.type_definition, desc = "Go to type definition" },
      { 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "Show hover" },
      -- LSP operations (,l prefix)
      { ',lr', vim.lsp.buf.rename, desc = "Rename symbol" },
      { ',lf', function() vim.lsp.buf.format({ async = true }) end, desc = "Format code" },
      { ',ll', vim.lsp.codelens.run, desc = "Run codelens" },
      { ',lR', ':LspRestart<CR>', desc = "Restart LSP" },
      { ',li', ':LspInfo<CR>', desc = "LSP info" },
      { ',ld', function() require('telescope.builtin').lsp_definitions() end, desc = "Search definitions" },
      { ',lt', function() require('telescope.builtin').lsp_type_definitions() end, desc = "Search type definitions" },
    },
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "eslint"
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })

      local buffer_autoformat = function(bufnr)
        local group = 'lsp_autoformat'
        vim.api.nvim_create_augroup(group, { clear = false })
        vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

        local filetype = vim.bo[bufnr].filetype

        if filetype ~= 'yaml' and filetype ~= 'yml' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            group = group,
            desc = 'LSP format on save',
            callback = function()
              -- note: do not enable async formatting
              vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
            end,
          })
        end
      end

      local function has_prettier()
        local root_dir = vim.fn.getcwd()
        local package_json = root_dir .. "/package.json"
        local node_modules = root_dir .. "/node_modules/.bin/prettier"

        -- Check if prettier is in dependencies or devDependencies
        if vim.fn.filereadable(package_json) == 1 then
          local content = vim.fn.readfile(package_json)
          local json = vim.fn.json_decode(table.concat(content))
          if json.dependencies and json.dependencies.prettier then
            return true
          end
          if json.devDependencies and json.devDependencies.prettier then
            return true
          end
        end

        -- Check if prettier is installed in node_modules
        return vim.fn.executable(node_modules) == 1
      end

      -- Configure null-ls for prettier
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            condition = function()
              return has_prettier()
            end,
            prefer_local = "node_modules/.bin",
          }),
        },
      })

      require("typescript-tools").setup({})

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local id = vim.tbl_get(event, 'data', 'client_id')
          local client = id and vim.lsp.get_client_by_id(id)
          if client == nil then
            return
          end

          -- make sure there is at least one client with formatting capabilities
          if client.supports_method('textDocument/formatting') then
            buffer_autoformat(event.buf)
          end
        end
      })
    end
  }
}
