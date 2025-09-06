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
