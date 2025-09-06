return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ["<Esc>"] = { "actions.close", mode = "n" },
                ["q"] = { "actions.close", mode = "n" },
            }
        })
        -- Если открыт nvim с папкой в качесте аргумента - 
        -- откроется менюшка oil и надо семнить рабочую директорию
        -- на текущую директорию открытую
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                local oil = require("oil")
                local current_dir = oil.get_current_dir()
                if current_dir and current_dir ~= "" and vim.fn.isdirectory(current_dir) == 1 then
                    vim.cmd("cd " .. vim.fn.fnameescape(current_dir))
                end
            end,
        })
        vim.keymap.set("n", "<leader>e", function()
            require("oil").toggle_float()
        end, {})
    end
}
