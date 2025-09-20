-- Настройка LSP-сервером с использованием Mason!

-- Сюда добавить название сервера который надо скачать
local required_servers = { "lua_ls", "clangd", "zls" }
local event = {
    "BufReadPre *.{lua,c,cpp,zig}",
    "BufNewFile *.{lua,c,cpp,zig}"
}

-- Функция для включения/выключения диагностики
local diagnostics_active = false
local function toggle_diagnostics()
    diagnostics_active = not diagnostics_active

    if diagnostics_active then
        vim.diagnostic.config({
            virtual_text = {
                virt_text_pos = 'right_align',
                suffix = " ",
            },
            signs = false,
            underline = false,
        })
    else
        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = false,
        })
    end
end

return {
    'neovim/nvim-lspconfig',
    event = event,
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            'mason-org/mason-lspconfig.nvim',
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = required_servers,
                })
            end,
        },
    },
    config = function()
        toggle_diagnostics()

        vim.keymap.set('n', '<leader>l', toggle_diagnostics, {
            noremap = true,
            silent = true,
        })

        local original_handler = vim.lsp.handlers["window/showMessage"]
        vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
            if result.message and result.message:find("refused to load this directory") then
                return
            end
            return original_handler(_, result, ctx)
        end
    end
}
