return {
  {
    -- :DiffViewOpen
    'sindrets/diffview.nvim',
    lazy = false,
  },
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    -- Shows git status in left rail, but also includes lots of other Git functionality
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'right_align'
      }
    },
    lazy = false, -- load on startup since git integration is commonly needed
    init = function()
      -- Make the current line blame more transparent
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {
        fg = "#5a6374", -- Rounds to the nearest theme color, I think
        italic = true,
      })
    end,
    keys = {
      { ']g',  function() require('gitsigns').next_hunk() end,                 desc = "Next git hunk" },
      { '[g',  function() require('gitsigns').prev_hunk() end,                 desc = "Previous git hunk" },
      { ',gs', function() require('gitsigns').stage_hunk() end,                desc = "Stage hunk" },
      { ',gr', function() require('gitsigns').reset_hunk() end,                desc = "Reset hunk" },
      { ',gS', function() require('gitsigns').stage_buffer() end,              desc = "Stage buffer" },
      { ',gR', function() require('gitsigns').reset_buffer() end,              desc = "Reset buffer" },
      { ',gb', function() require('gitsigns').blame_line() end,                desc = "Blame line" },
      { ',gp', function() require('gitsigns').preview_hunk() end,              desc = "Preview hunk" },
      { ',gd', function() require('gitsigns').diffthis() end,                  desc = "Diff this" },
      { ',gB', function() require('gitsigns').blame_line({ full = true }) end, desc = "Blame line full" },
      { ',gt', function() require('gitsigns').toggle_current_line_blame() end, desc = "Toggle line blame" },
      { ',gx', function() require('gitsigns').toggle_deleted() end,            desc = "Toggle deleted" },
    }
  },


  {
    'tpope/vim-fugitive',
    lazy = false, -- load on startup since git integration is commonly needed
  }
}
