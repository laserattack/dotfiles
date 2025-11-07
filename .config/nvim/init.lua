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

-- Чтобы можно было классические файлы с синтаксисисом
-- Хранить в /lua/plugins/syntax
vim.opt.runtimepath:prepend(CFGP.."/lua/plugins")

-- Включение диагностики
UTILS.toggle_diagnostics()
