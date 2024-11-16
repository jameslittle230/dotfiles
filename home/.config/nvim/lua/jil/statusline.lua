-- Statusline configuration
local M = {}

-- Mode mappings
local modes = {
  ['n']  = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v']  = 'VISUAL',
  ['V']  = 'V-LINE',
  ['']   = 'V-BLOCK',
  ['s']  = 'SELECT',
  ['S']  = 'S-LINE',
  ['']   = 'S-BLOCK',
  ['i']  = 'INSERT',
  ['ic'] = 'INSERT',
  ['R']  = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['c']  = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r']  = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!']  = 'SHELL',
  ['t']  = 'TERMINAL'
}

-- Colors for different modes
local mode_colors = {
  ['NORMAL']  = '%#StatusLineNormal#',
  ['INSERT']  = '%#StatusLineInsert#',
  ['VISUAL']  = '%#StatusLineVisual#',
  ['V-LINE']  = '%#StatusLineVisual#',
  ['V-BLOCK'] = '%#StatusLineVisual#',
  ['REPLACE'] = '%#StatusLineReplace#',
  ['COMMAND'] = '%#StatusLineCommand#'
}

-- Make these functions available globally
function _G.StatusLineMode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode]):upper()
end

function _G.StatusLineGitBranch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return string.format('  %s ', branch)
  end
  return ''
end

function _G.StatusLineFilename()
  local filename = vim.fn.expand('%:t')
  if filename == '' then return '[No Name]' end
  return filename
end

function _G.StatusLineFileType()
  local filetype = vim.bo.filetype
  if filetype == '' then return 'no ft' end
  return filetype
end

function _G.StatusLinePosition()
  return string.format(' %d:%d ', vim.fn.line('.'), vim.fn.col('.'))
end

-- Build statusline function
function _G.StatusLine()
  local statusline = table.concat({
    '%#StatusLine#',
    '%{%v:lua.StatusLineMode()%}',
    '%#StatusLineGit#',
    '%{%v:lua.StatusLineGitBranch()%}',
    '%#StatusLine#',
    ' %f',
    ' %m%r%h%w',
    '%=',
    '%#StatusLineFileType#',
    ' %{&fileformat} | %{&fileencoding?&fileencoding:&encoding} | %Y ',
    '%#StatusLine#',
    '%{%v:lua.StatusLinePosition()%}'
  })
  return statusline
end

-- Define highlight groups
vim.cmd([[
    hi StatusLineNormal  guibg=#98c379 guifg=#282c34 gui=bold
    hi StatusLineInsert  guibg=#61afef guifg=#282c34 gui=bold
    hi StatusLineVisual  guibg=#c678dd guifg=#282c34 gui=bold
    hi StatusLineReplace guibg=#e06c75 guifg=#282c34 gui=bold
    hi StatusLineCommand guibg=#e5c07b guifg=#282c34 gui=bold
    hi StatusLineGit     guibg=#4b5263 guifg=#abb2bf gui=italic
    hi StatusLineFileType guibg=#4b5263 guifg=#abb2bf
]])

-- Set the statusline
vim.o.statusline = '%!v:lua.StatusLine()'

-- Return the module (optional, for requiring)
return M
