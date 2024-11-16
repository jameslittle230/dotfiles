vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

require("jil.settings")
require("jil.reload")
require("jil.floating-terminal")
require('jil.lazy')
require('jil.statusline')

-- this one needs to be last
require("jil.remaps")


vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
