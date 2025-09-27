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

local config = {
    name = "jdtls",
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux'),
        '-data', vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    },
    root_dir = vim.loop.cwd(),
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-25",
                        path = "/home/serr/software/jdk-25",
                    }
                }
            }
        },
    },
}

config.on_attach = function(client, bufnr)
    if client.supports_method("textDocument/semanticTokens") then
        -- Чтобы не перебивало подсветку от триситтера
        client.server_capabilities.semanticTokensProvider = nil
    end
    toggle_diagnostics()
    vim.keymap.set('n', '<leader>l', toggle_diagnostics, {
        noremap = true,
        silent = true,
        desc = "LSP toggle diagnostic"
    })
end

require('jdtls').start_or_attach(config)
