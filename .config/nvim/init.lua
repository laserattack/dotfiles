-- global vars
CFGP = vim.fn.stdpath('config')
HOME = vim.fn.expand('~')

-- settings
require("settings")
-- bindings
require("keymap")
-- plugins settings
require("plugins/init")

-- classic syntax files in /lua/plugins/syntax
vim.opt.runtimepath:prepend(CFGP.."/lua/plugins")
