-- setup lsp servers using mason

return {
    'neovim/nvim-lspconfig',
    event = {
        "BufReadPre *.{lua,c,cpp,zig,py,go}",
        "BufNewFile *.{lua,c,cpp,zig,py,go}"
    },
    dependencies = {
        -- With this plugin you can install servers via :MasonInstall servername
        -- and it automatically adds the directory '~/.local/share/nvim/mason/bin'
        -- (where server folders are located) to the PATH where LSP server executables are searched
        { "mason-org/mason.nvim", opts = {} },
    },
    config = function()
        -- HACK: The LSP root directory (where analysis starts from and goes downwards)
        -- for all servers is set to the current working directory!

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
                    gofumpt     = true,
                }
            },
            on_attach = function(_, bufnr)
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
