return {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme miasma")
    end,
}

-- return {
--     dir = CFGP.."/lua/plugins/laserattack/theme.nvim",
--     dependencies = {
--         "tjdevries/colorbuddy.nvim"
--     },
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme("laserattack")
--     end
-- }
