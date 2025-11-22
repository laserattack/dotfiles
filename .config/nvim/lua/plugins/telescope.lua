local vimgrep_arguments = {
    "rg",
    "--hidden",
    "--no-ignore",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    -- "--glob", "!**/deps/**",
    "--glob", "!**/.git/**"
}

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        telescope.setup({
            defaults = {
                mappings = {
                    i = { ['<Esc>'] = actions.close },
                    n = { ['<Esc>'] = actions.close },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    -- Ищу через rg, игнорю директорию с зависимостями
                    find_command = {
                        "rg", "--files", "--hidden", "--no-ignore",
                        "--glob", "!**/.git/**"
                    },
                },
                live_grep = {
                    vimgrep_arguments = vimgrep_arguments,
                }
            },
        })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find file" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope find content (grep)" })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope find keymap" })
        -- vim.keymap.set('n', '<leader>ft', function()
        --     require('telescope.builtin').grep_string({
        --         search = 'NOTE:|TODO:|FIX:|HACK:|WARN:|PERF:|TEST:',
        --         use_regex = true,
        --         vimgrep_arguments = vimgrep_arguments,
        --     })
        -- end, { desc = "Telescope find TODO comments" })
        vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Telescope find in current buffer" })
    end
}
