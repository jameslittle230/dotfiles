vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

require("jil.settings")
require("jil.terminal")
require('jil.lazy')
require('jil.log-variables').setup({})

-- this one needs to be last
require("jil.remaps")
