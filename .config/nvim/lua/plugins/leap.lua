return {
    "ggandor/leap.nvim",
    config = function()
        require("leap").setup({ preview = false })
        vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
        vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
    end
}
