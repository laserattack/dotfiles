return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = {
            preset = "default",
            ["C-s"] = { "show" },
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
                auto_show = false,
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
