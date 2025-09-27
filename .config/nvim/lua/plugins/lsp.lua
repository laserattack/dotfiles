-- Настройка LSP-серверов с использованием Mason!

local event = {
    "BufReadPre *.{lua,c,cpp,zig,py}",
    "BufNewFile *.{lua,c,cpp,zig,py}"
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
        -- с помощью этого плагина можно устанавливать сервера через :MasonInstall servername
        -- и он автоматически кладет директорию '~/.local/share/nvim/mason/bin'
        -- (там папки серверов) в пути где ищутся исполняемые файлы lsp серверов плагином lspconfig
        { "mason-org/mason.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require('lspconfig')

        lspconfig.lua_ls.setup({})
        lspconfig.clangd.setup({})
        lspconfig.zls.setup({})
        lspconfig.pylsp.setup({})

        toggle_diagnostics()

        vim.keymap.set('n', '<leader>l', toggle_diagnostics, {
            noremap = true,
            silent = true,
            desc = "LSP toggle diagnostic"
        })

        -- дальше всякие фильтры сообщений
        local original_handler = vim.lsp.handlers["window/showMessage"]
        vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
            if result.message and result.message:find("refused to load this directory") then
                return
            end
            return original_handler(_, result, ctx)
        end
    end
}
