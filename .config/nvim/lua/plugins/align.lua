return {
    'junegunn/vim-easy-align',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { noremap = false })
        vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { noremap = false })
    end
}
