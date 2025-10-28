return {
  {
    'nvim-mini/mini.move',
    version = '*',
    opts = {
      mappings = {
        -- move visual selection in visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<S-h>',
        right = '<S-l>',
        down = '<S-j>',
        up = '<S-k>',

        -- Move current line in Normal mode
        line_left = '<C-h>',
        line_right = '<C-l>',
        line_down = '<C-j>',
        line_up = '<C-k>',
      },
    }
  },
  { 'nvim-mini/mini.tabline',    version = '*', opts = {} },
  { 'nvim-mini/mini.cursorword', version = '*' },
  -- { 'nvim-mini/mini.ai',         version = '*' },
}
