-- Глобальная переменная с путем до конфига
CFGP = vim.fn.stdpath('config')
HOME = vim.fn.expand('~')

-- Подгружает настройки nvim`a
require("settings")
-- Подгружает бинды
require("keymap")
-- Подгружает плагины и их настройки
require("plugins/init")

-- Добавление рабочей директории (из который запускается nvim)
-- в пути рантайма (позволяет брать, например, подсветку
-- из подпапки syntax текущей рабочей директории)
vim.opt.runtimepath:prepend(CFGP.."/lua/plugins")

local utils = require("utils")
utils.toggle_diagnostics()
vim.keymap.set(
    'n', '<leader>l',
    utils.toggle_diagnostics,
    {
        noremap = true,
        silent = true,
        desc = "LSP toggle diagnostic"
    }
)

-- При открытии nvim рабочая директория меняется
-- на директорию с открываемым файлом/папкой
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        local target_dir = data.file
        if vim.fn.isdirectory(data.file) ~= 1 then
            target_dir = vim.fn.fnamemodify(data.file, ":h")
        end
        if target_dir and target_dir ~= "" and vim.fn.isdirectory(target_dir) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(target_dir))
        end
    end,
})

-- Автоматическое переключение на US раскладку
-- при заходе в NormalMode (в системе требуется утилита xkb-switch)
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
