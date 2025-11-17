-- Настройка менеджера плагинов

local plugins = {
    "plugins/vim-move",
    "plugins/telescope",
    "plugins/theme",
    -- "plugins/blink-cmp",
    -- "plugins/lsp",
    "plugins/tree-sitter",
    "plugins/mini-pairs",
    "plugins/nvim-tree",
    "plugins/todo-comments",
    "plugins/leap",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)
local for_setup = {}
for _, v in ipairs(plugins) do
    for_setup[#for_setup+1] = require(v)
end
require("lazy").setup(for_setup)
