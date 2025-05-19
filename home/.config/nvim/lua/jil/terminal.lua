-- Function to create a floating terminal
local function open_floating_terminal()
  vim.cmd('split')
  vim.cmd('resize 15')

  -- Open terminal in the buffer
  vim.cmd('terminal')
  vim.cmd('startinsert')
end

-- Set up the keybinding (Ctrl+t)
vim.keymap.set('n', '<C-t>', open_floating_terminal, { noremap = true, silent = true })

-- Easy escape from terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<Leader><Esc>', '<C-\\><C-n>:q', { noremap = true, silent = true })
