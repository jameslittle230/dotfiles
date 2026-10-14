-- Settings shared by every laptop. Loaded by init.lua.
local prettier = { "prettierd", "prettier", stop_after_first = true }

-- type hints for ts_ls; shown by the LspAttach autocmd in setup()
local ts_inlay_hints = {
  inlayHints = {
    includeInlayParameterNameHints = "literals",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayEnumMemberValueHints = true,
  },
}

return {
  lsp_servers = {
    clangd = {},
    rust_analyzer = {},
    ts_ls = { typescript = ts_inlay_hints, javascript = ts_inlay_hints },
  },

  formatters_by_ft = {
    json = prettier,
    jsonc = prettier,
    yaml = prettier,
    scss = prettier,
    markdoc = { "prettier_markdoc" },
  },

  formatters = {
    -- prettier picks its parser from the file extension, and it doesn't know
    -- .mdoc (and parses .mdx as MDX, which rejects {% %} tags)
    prettier_markdoc = { inherit = "prettier", prepend_args = { "--parser", "markdown" } },
  },

  setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "ts_ls" then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })
  end,
}
