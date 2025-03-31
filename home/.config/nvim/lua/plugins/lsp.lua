return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

  {
    'nvim-lua/lsp-status.nvim',
    config = function()
      local lsp_status = require('lsp-status')

      -- Configure to use ASCII symbols only
      lsp_status.config({
        indicator_errors = 'E',
        indicator_warnings = 'W',
        indicator_info = 'I',
        indicator_hint = 'H',
        indicator_ok = 'OK',
        spinner_frames = { '-', '\\', '|', '/' },
        status_symbol = ' LSP',
        component_separator = ' | ',
        indicator_separator = ' ',
      })

      lsp_status.register_progress()
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end
  },

  -- LSP
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'nvimtools/none-ls.nvim' }
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(_event)
          -- Keybindings might go here, but I have them in remaps.lua instead.
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "eslint"
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          ["denols"] = function()
            require('lspconfig').denols.setup({
              root_dir = require('lspconfig').util.root_pattern("deno.json", "deno.jsonc"),
              init_options = {
                enable = true,
                lint = true,
                unstable = true,
                suggest = {
                  imports = {
                    hosts = {
                      ["https://deno.land"] = true,
                      ["https://cdn.nest.land"] = true,
                      ["https://crux.land"] = true
                    }
                  }
                }
              }
            })
          end
        }
      })

      require('lspconfig').ts_ls.setup({
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

      -- Setup typescript LSP
      require('lspconfig').ts_ls.setup({
        on_attach = function(client, _bufnr)
          -- Disable tsserver formatting if prettier is available
          if has_prettier() then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          -- Your existing keymaps and other on_attach logic here
        end,
        -- Your other tsserver settings here
        root_dir = require('lspconfig').util.root_pattern("package.json"),
        single_file_support = false
      })

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
