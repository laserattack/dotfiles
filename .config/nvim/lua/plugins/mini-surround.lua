-- Плагин позволяет обрамлять текст в парные символы

return {
    'nvim-mini/mini.surround',
    config = function ()
        require('mini.surround').setup()
    end
}
