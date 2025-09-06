return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ["<Esc>"] = { "actions.close", mode = "n" },
                ["q"] = { "actions.close", mode = "n" },
            }
        })
        vim.keymap.set("n", "<leader>e", function()
            require("oil").toggle_float()
        end, {})
    end
}
