-- Настройка treesitter`a

return {
    "nvim-treesitter/nvim-treesitter",
    -- Добавляешь новый парсер - укажи сюда
    -- расширение файлов, которые он обрабатывает
    event = {
        "BufReadPre *.{lua,c,cpp,zig,py,go,json,html,css,js,pl}",
        "BufNewFile *.{lua,c,cpp,zig,py,go,json,html,css,js,pl}"
    },
    config = function()
        -- Тут надо указать нужные языки
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "cpp", "lua", "zig", "python", "perl",
                "go", "json", "html", "css", "javascript"
            },
            sync_install = true,
            auto_install = false,
            highlight = {
                enable = true,
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
