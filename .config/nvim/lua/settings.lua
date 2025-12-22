vim.o.list = true
vim.opt.listchars = {
    trail = "·",
    lead = "·",
    tab = "» "
}

vim.opt.shortmess:append("sI")

vim.opt.termguicolors = true

vim.opt.modeline  = true
vim.opt.modelines = 5

-- netrw settings
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3

-- disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.updatetime = 300

-- for work with system buffer
vim.opt.clipboard = "unnamedplus"

-- disable swap files
vim.opt.swapfile = false

-- relative file lines numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- highlight cur line and number
vim.opt.cursorline    = true
vim.opt.cursorlineopt = "both"

vim.opt.wrap     = false
vim.wo.linebreak = true

-- tab = 4 spaces
vim.opt.expandtab   = true -- tabs = spaces
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.smarttab    = true
vim.opt.autoindent  = true
vim.opt.smartindent = true

vim.opt.guicursor = "a:block"

-- automatic layout change when entering NormalMode (xkb-switch)
vim.api.nvim_create_autocmd({
    "InsertLeave",
    "CmdlineLeave",
    "TermLeave",
    "VimEnter",
}, {
    callback = function()
        vim.fn.system("xkb-switch -s us")
    end,
})
