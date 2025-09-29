-- Настройка LSP-серверов с использованием Mason!

-- NOTE: LSP сервер для java настраивается в ftplugin/java.lua
-- и подключается через lua/plugins/jdtls.lua

-- Функция для включения/выключения диагностики
-- TODO: Вынести в utils эту ф-ю, т.к. она еще и в ftplugin/java.lua используется
-- и вообще подумать что еще повыносить в utils
local diagnostics_active = false
local function update_statusline()
    local status = diagnostics_active and "LSPD:ON" or "LSPD:OFF"
    vim.opt.statusline = status .. " %f %h%w%m%r%=%l:%c %P"
end
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
    update_statusline()
end

return {
    -- регистрирует серверы в системе LSP Neovim
    'neovim/nvim-lspconfig',
    event = {
        "BufReadPre *.{lua,c,cpp,zig,py}",
        "BufNewFile *.{lua,c,cpp,zig,py}"
    },
    dependencies = {
        -- с помощью этого плагина можно устанавливать сервера через :MasonInstall servername
        -- и он автоматически кладет директорию '~/.local/share/nvim/mason/bin'
        -- (там папки серверов) в пути где ищутся исполняемые файлы lsp серверов
        { "mason-org/mason.nvim", opts = {} },
    },
    config = function()

        -- Сервера настраиваются через config и становятся доступными через enable
        -- Если сконфигурировать но не сделать enable, то сервер просто не будет работать

        -- HACK: LSP директория начала анализа (с которой вниз начинается анализ)
        -- для всех серверов является текущая рабочая директория!.
        -- Так что neovim для редактирования чего то что использует lsp надо запускать
        -- через nvim path/to/folder а не через nvim path/to/file

        vim.lsp.config('lua_ls', {
            root_dir = vim.fn.getcwd(),
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    }
                }
            }
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('clangd', {
            root_dir = vim.fn.getcwd(),
        })
        vim.lsp.enable('clangd')

        vim.lsp.config('zls', {
            root_dir = vim.fn.getcwd(),
        })
        vim.lsp.enable('zls')

        vim.lsp.config('pylsp', {
            root_dir = vim.fn.getcwd(),
        })
        vim.lsp.enable('pylsp')

        toggle_diagnostics()

        vim.keymap.set('n', '<leader>l', toggle_diagnostics, {
            noremap = true,
            silent = true,
            desc = "LSP toggle diagnostic"
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
