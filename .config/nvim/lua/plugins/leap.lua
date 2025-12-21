return {
    "ggandor/leap.nvim",
    config = function()
        vim.api.nvim_set_hl(0, "LeapMatch", { link = "None" })
        vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
        vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
    end
}
