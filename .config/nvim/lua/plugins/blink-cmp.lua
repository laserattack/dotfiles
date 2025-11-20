return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = {
            preset = "none",
            ['<C-s>'] = { 'show', 'hide' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        completion = {
            auto_show = false,
            trigger = {
                show_on_keyword = false,
            },
            documentation = {
                auto_show = true,
            }
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "buffer", "lsp", "path" },
        },
        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}
