return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
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
