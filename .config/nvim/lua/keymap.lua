-- Базовые бинды (не относящиеся к плагинам)
-- Бинды плагинов в файликах с подключением плагинов
vim.g.mapleader = " "

vim.keymap.set(
    'n', '<leader>h',
    function()
        local commands_file = CFGP..'/commands.md'
        vim.cmd('tabnew ' .. commands_file)
    end,
    {
        noremap = true,
        silent = true,
        desc = "Open commands.md in new tab"
    }
)

vim.keymap.set('n', '<leader>tv', function()
    vim.cmd('vsplit | terminal')
end, {
    noremap = true,
    silent = true,
    desc = "Open terminal in vertical split"
})

vim.keymap.set('n', '<leader>tg', function()
    vim.cmd('split | terminal')
end, {
    noremap = true,
    silent = true,
    desc = "Open terminal in horizontal split"
})

vim.keymap.set('n', '<leader>tt', function()
    vim.cmd('tabnew | terminal')
end, {
    noremap = true,
    silent = true,
    desc = "Open terminal in new tab"
})

vim.keymap.set(
    't', '<Esc>',
    function()
        vim.cmd("stopinsert")
    end,
    {
        noremap = true,
        silent = true,
        desc = "Leave terminal insert mode"
    }
)

vim.keymap.set("v", "<Tab>", ">gv", {
    noremap = true,
    silent = true,
    desc = "Move the selected block to the right"
})

vim.keymap.set("v", "<S-Tab>", "<gv", {
    noremap = true,
    silent = true,
    desc = "Move the selected block to the left"
})

vim.keymap.set('v', 'p', 'p:let @+=@0<CR>', {
    noremap = true,
    silent = true,
    desc = "Pasting through the `p` does not copy anything to the buffer"
})

vim.keymap.set('n', 'cd', ':lcd %:p:h<CR>', {
    noremap = true,
    silent = true,
    desc = "Change working directory to current file directory"
})

vim.keymap.set(
    'n', '<leader>w',
    function()
        vim.opt.wrap = not vim.opt.wrap:get()
    end,
    {
        noremap = true,
        silent = true,
        desc = "Toggle line wrapping"
    }
)

vim.keymap.set({'n','v'}, '<Up>', '<Nop>', {
    noremap = true,
    silent = true,
    desc = "Disable arrow up key"
})

vim.keymap.set({'n','v'}, '<Down>', '<Nop>', {
    noremap = true,
    silent = true,
    desc = "Disable arrow down key"
})

vim.keymap.set({'n','v'}, '<Left>', '<Nop>', {
    noremap = true,
    silent = true,
    desc = "Disable arrow left key"
})

vim.keymap.set({'n','v'}, '<Right>', '<Nop>', {
    noremap = true,
    silent = true,
    desc = "Disable arrow right key"
})

vim.keymap.set(
    'n', '<leader>l', UTILS.toggle_diagnostics, {
    noremap = true,
    silent = true,
    desc = "Toggle diagnostic"
})
