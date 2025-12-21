return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>e", ":NvimTreeToggle<CR>",
            silent = true,
            noremap = true,
            desc  = "nvim-tree toggle"
        }
    },
    config = function()
        local width = math.floor(vim.o.columns * 0.7)
        local height = math.floor(vim.o.lines * 0.7)

        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
            vim.keymap.set('n', '<Esc>', api.tree.close, opts('Close'))
        end

        require("nvim-tree").setup({
            hijack_netrw = false,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                float = {
                    enable = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = width,
                        height = height,
                        row = (vim.o.lines - height) / 2,
                        col = (vim.o.columns - width) / 2,
                    },
                },
                number = true,
                relativenumber = true,
            },
            renderer = {
                group_empty = false,
            },
            filters = {
                enable = true,
                git_ignored = false,
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
                no_bookmark = false,
                custom = {},
                exclude = {},
            },
            live_filter = {
                always_show_folders = false,
            },
            on_attach = on_attach,
        })
    end,
}
