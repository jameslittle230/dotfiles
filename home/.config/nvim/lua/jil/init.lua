vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

require("jil.settings")
require("jil.reload")
require("jil.floating-terminal")
require('jil.lazy')

-- this one needs to be last
require("jil.remaps")
