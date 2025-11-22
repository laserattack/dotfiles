return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
    },
    config = function()
        vim.keymap.set('n', '<leader>ft', ':TodoTelescope', {
            noremap = true,
            silent = true,
            desc = "Change working directory to current file directory"
        })
    end
}
