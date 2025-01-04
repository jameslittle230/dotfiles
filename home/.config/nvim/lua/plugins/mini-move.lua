return {
  'echasnovski/mini.move',
  version = '*',
  opts = {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
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
}
