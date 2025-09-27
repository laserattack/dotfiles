-- Настройка treesitter`a

return {
    "nvim-treesitter/nvim-treesitter",
    -- Добавляешь новый парсер - укажи сюда
    -- расширение файлов, которые он обрабатывает
    event = {
        "BufReadPre *.{lua,c,cpp,zig,py,java}",
        "BufNewFile *.{lua,c,cpp,zig,py,java}"
    },
    config = function()
        -- Тут надо указать нужные языки
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "zig", "python", "java" },
            sync_install = true,
            auto_install = false,
            highlight = {
                enable = true,
                -- Сюда можно написать список парсеров которые отключить 
                disable = { "markdown", "markdown_inline" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>v",
                    node_incremental = "<leader>v",
                    node_decremental = "<leader>V",
                },
            },
        })
    end
}
