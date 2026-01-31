return {
  {
    "EdenEast/nightfox.nvim",
    config = function() vim.cmd.colorscheme('nightfox') end
  },

  { 'nvim-mini/mini.ai',         version = '*', opts = {} },
  { 'nvim-mini/mini.bracketed',  version = '*', opts = {} },
  { 'nvim-mini/mini.bufremove',  version = '*', opts = {} },
  { 'nvim-mini/mini.tabline',    version = '*', opts = {} },
  { 'nvim-mini/mini.trailspace', version = '*', opts = {} },
  { 'nvim-mini/mini.notify',     version = '*', opts = {} },
  { 'nvim-mini/mini.cmdline',    version = '*', opts = {} },
  { 'nvim-mini/mini.splitjoin',  version = '*', opts = {} }, -- gS
  { 'nvim-mini/mini.cursorword', version = '*', opts = {} },

  {
    'nvim-mini/mini.files',
    version = '*',
    opts = {
      options = {
        use_as_default_explorer = false,
      },
    },
  },


  { "folke/which-key.nvim",                opts = {} },

  { 'windwp/nvim-autopairs',               event = "InsertEnter", config = true, opts = {} },
  { 'windwp/nvim-ts-autotag',              lazy = false,          opts = {} },
  { 'kylechui/nvim-surround',              lazy = false,          opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",          opts = {} },
  { 'numToStr/Comment.nvim',               opts = {} },

  { 'lewis6991/gitsigns.nvim',             opts = {} },
  { 'tpope/vim-fugitive',                  lazy = false },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {}
  },

  {
    'Chaitanyabsprip/fastaction.nvim',
    opts = { dismiss_keys = { "j", "k", "<ESC>", "q" }, }
  },

  {
    'nvim-mini/mini.move',
    version = '*',
    opts = {
      mappings = {
        left = '<S-h>',
        right = '<S-l>',
        down = '<S-j>',
        up = '<S-k>',
      }
    },
    options = {
      reindent_linewise = true,
    },
  },


  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {},
      dim = {},
      input = {},
    }
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async', 'luukvbaal/statuscol.nvim' },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldcolumn = '1'
      vim.opt.fillchars = {
        eob = " ",
        fold = " ",
        foldopen = "▼",
        foldsep = " ",
        foldclose = "▶",
      }

      require('ufo').setup({
        provider_selector = function()
          return { 'lsp', 'indent' }
        end
      })

      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { "%s" },                       click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc },           click = "v:lua.ScLa", },
          { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        }
      })
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      pickers = {
        find_files = {
          hidden = true,
          find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' }
        },
        live_grep = {
          additional_args = function() return { '--hidden' } end
        }
      },
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'EdenEast/nightfox.nvim' },
    opts = {
      options = {
        section_separators = "",
        component_separators = ""
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icons_enabled = false }, 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          { 'lsp_status', ignore_lsp = { 'null-ls' } },
          'encoding',
          { 'filetype',   icons_enabled = false },
        },
        lualine_y = { 'searchcount', 'progress' },
        lualine_z = { 'location' }
      },
    }
  }
}
