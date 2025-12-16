-- Базовые настройки (не относящиеся к плагинам)
-- Отключить стандартный стартовый экран

-- Точки вместо пробелов в начале/конце строки
vim.o.list = true
vim.opt.listchars = {
    trail = "·",
    lead = "·",
    tab = "» "
}

vim.opt.shortmess:append("sI")

-- Огромная палитра цветов
vim.opt.termguicolors = true

-- модлайн в файлах
vim.opt.modeline = true
vim.opt.modelines = 5

-- Тильды (которые вместо номеров в пустых строках) на пробелы заменяю
-- vim.opt.fillchars = { eob = " " }

-- Настройка netrw
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3

-- Отключение netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- всегда показывать строку с вкладками
-- vim.opt.showtabline = 2
--
-- слева от номеров строк пустое пространство размером с 1 символ
-- vim.opt.signcolumn = "yes"
--
-- Чтобы не было подвисаний при работе LSP
vim.opt.updatetime = 300

-- Для нормального взамодействия с системным буфером
vim.opt.clipboard = "unnamedplus"

-- Отключение swap файлов
vim.opt.swapfile = false

-- Относительные номера строк
vim.opt.number = true
vim.opt.relativenumber = true

-- Подсветка текущей строки
vim.opt.cursorline = true -- и номера строки
vim.opt.cursorlineopt = "both" -- и самой строки

-- Ограничительная вертикальная линия на 80-м символе
-- vim.opt.colorcolumn = "80"

-- Чтобы не было разбиения строки если она не помещается в ширину экрана
vim.opt.wrap = false
vim.wo.linebreak = true

-- Оффест скролла чтобы не нужно было доходить до самого низа
-- vim.opt.scrolloff = 8

-- Таб = 4 пробела
vim.opt.expandtab = true -- табы -> пробелы
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Настройка внешнего вида курсора (во всех режимах одинаковый + мигает)
vim.opt.guicursor = "a:block-blinkon500-blinkoff500"

-- При открытии nvim рабочая директория меняется
-- на директорию с открываемым файлом/папкой
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function(data)
--         local target_dir = data.file
--         if vim.fn.isdirectory(data.file) ~= 1 then
--             target_dir = vim.fn.fnamemodify(data.file, ":h")
--         end
--         if target_dir and target_dir ~= "" and vim.fn.isdirectory(target_dir) == 1 then
--             vim.cmd("cd " .. vim.fn.fnameescape(target_dir))
--         end
--     end,
-- })

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
