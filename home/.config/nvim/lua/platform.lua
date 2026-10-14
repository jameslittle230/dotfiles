-- Settings shared by every laptop. Loaded by init.lua.
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  lsp_servers = {
    clangd = {},
    rust_analyzer = {},
    ts_ls = {},
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
}
