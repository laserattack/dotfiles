-- Настройка treesitter`a

return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "cpp", "lua", "zig", "python", "perl",
                "go", "json", "html", "css", "javascript"
            },
            sync_install = true,
            auto_install = false,
            highlight = {
                enable                            = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable  = true,
                keymaps = {
                    init_selection   = "<leader>v",
                    node_incremental = "<leader>v",
                    node_decremental = "<leader>V",
                },
            },
        })
    end
}
