-- file: lua/variable_logger/init.lua
local M = {}

-- Define comment templates for different languages
M.comment_templates = {
  lua = 'print("JIL %d", %s)',
  python = 'print(f"JIL {%d}: {%s = %s}")',
  javascript = 'console.log("JIL %d", {%s});',
  typescript = 'console.log("JIL %d", {%s});',
  tsx = 'console.log("JIL %d", {%s});',
  ruby = 'puts "JIL %d: #{%s.inspect}"',
  bash = 'echo "JIL %d: $%s=${%s}"',
  rust = 'println!("JIL %d: {:?}", %s);',
  go = 'fmt.Printf("JIL %d: %s = %%+v\n", %s)',
}

-- Get supported languages from the keys of comment_templates
function M.get_supported_languages()
  local languages = {}
  for lang, _ in pairs(M.comment_templates) do
    table.insert(languages, lang)
  end
  return languages
end

-- Setup function for the plugin
function M.setup(opts)
  opts = opts or {}

  -- Allow overriding defaults through options
  M.comment_templates = vim.tbl_extend("force", M.comment_templates, opts.templates or {})
  local keybinding = opts.keybinding or '<leader>cn'

  -- Configure treesitter
  require('nvim-treesitter.configs').setup {
    ensure_installed = M.get_supported_languages(),
    highlight = { enable = true },
  }

  -- Create autocommands for each language
  local group = vim.api.nvim_create_augroup("VariableLogger", { clear = true })
  for lang, _ in pairs(M.comment_templates) do
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = lang,
      callback = function()
        vim.keymap.set('n', keybinding, M.log_variable, {
          buffer = true,
          desc = "Log variable under cursor"
        })
      end
    })
  end
end

-- Function to log variable under cursor
function M.log_variable()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[buf].filetype
  local template = M.comment_templates[filetype]

  if not template then
    vim.notify("No log template for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  local pos = vim.api.nvim_win_get_cursor(0)
  local line_number = pos[1] - 1
  local col_number = pos[2]

  local parser = vim.treesitter.get_parser(buf)
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse(filetype, [[
    (identifier) @var
  ]])

  -- Find the variable under the cursor
  for id, node in query:iter_captures(root, buf, line_number, line_number + 1) do
    if node:type() == "identifier" then
      local start_row, start_col, end_row, end_col = node:range()
      if start_row == line_number and start_col <= col_number and end_col >= col_number then
        -- Get the variable name
        local var_name = vim.treesitter.get_node_text(node, buf)

        -- Prepare the log statement using the template
        local log_statement = string.format(template, line_number + 1, var_name)

        -- Insert the log statement below the current line
        vim.api.nvim_buf_set_lines(buf, line_number + 1, line_number + 1, false, { log_statement })
        return
      end
    end
  end

  vim.notify("No variable found under cursor", vim.log.levels.INFO)
end

return M
