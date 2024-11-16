-- Function to create a floating terminal
local function open_floating_terminal()
  -- Get editor dimensions
  local columns = vim.o.columns
  local lines = vim.o.lines

  -- Calculate floating window size
  local width = math.floor(columns * 0.6)
  local height = math.floor(lines * 0.6)

  -- Calculate starting position
  local col = math.floor((columns - width) / 2)
  local row = math.floor((lines - height) / 2)

  -- Set window options
  local opts = {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded'
  }

  -- Create buffer and window
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Open terminal in the buffer
  vim.cmd('terminal')
  vim.cmd('startinsert')
end

-- Set up the keybinding (Ctrl+t)
vim.keymap.set('n', '<C-t>', open_floating_terminal, { noremap = true, silent = true })

-- Easy escape from terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
