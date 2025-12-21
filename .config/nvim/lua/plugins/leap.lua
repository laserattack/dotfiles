return {
    "ggandor/leap.nvim",
    config = function()
        require("leap").setup({
            highlight_unlabeled_phase_one_targets = false,
        })
        vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
        vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
    end
}
