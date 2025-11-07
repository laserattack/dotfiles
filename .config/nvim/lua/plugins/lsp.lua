-- Настройка LSP-серверов с использованием Mason!

return {
    -- регистрирует серверы в системе LSP Neovim
    'neovim/nvim-lspconfig',
    event = {
        "BufReadPre *.{lua,c,cpp,zig,py,go}",
        "BufNewFile *.{lua,c,cpp,zig,py,go}"
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

        vim.lsp.config('gopls', {
            root_dir = vim.fn.getcwd(),
            settings = {
                gopls = {
                    staticcheck = true,
                    gofumpt = true,
                }
            },
            on_attach = function(_, bufnr)
                -- При подключении LSP к буферу создается эта AutoCmd
                -- которая при записи в буффер форматирует его
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
        })
        vim.lsp.enable('gopls')

        local original_handler = vim.lsp.handlers["window/showMessage"]
        vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
            if result.message and result.message:find("refused to load this directory") then
                return
            end
            return original_handler(_, result, ctx)
        end
    end
}
