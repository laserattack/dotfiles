-- Глобальные переменные, используемые в разных модулях
CFGP = vim.fn.stdpath('config')
HOME = vim.fn.expand('~')
UTILS = require("utils")

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

-- Включение диагностики
UTILS.toggle_diagnostics()
