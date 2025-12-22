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
        local function get_window_config()
            local ui = vim.api.nvim_list_uis()[1]
            local screen_width = ui.width
            local screen_height = ui.height
            local width = math.floor(screen_width * 0.7)
            local height = math.floor(screen_height * 0.7)
            
            return {
                relative = "editor",
                border = "rounded",
                width = width,
                height = height,
                row = (screen_height - height) / 2,
                col = (screen_width - width) / 2,
            }
        end

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
                    open_win_config = function()
                        return get_window_config()
                    end,
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

        vim.api.nvim_create_autocmd("VimResized", {
            callback = function()
                local tree = require("nvim-tree.api").tree
                if tree.is_visible() then
                    tree.close()
                    tree.open()
                end
            end,
        })
    end,
}
