return {
    "justinmk/vim-sneak",
    init = function()
        vim.g.sneak#label = 1

        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>Sneak_s")
        vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>Sneak_S")
    end
}

-- return {
--     "ggandor/leap.nvim",
--     config = function()
--         vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
--         vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
--     end
-- }
