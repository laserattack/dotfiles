local diagnostics_active = false

local function update_statusline()
    local status = diagnostics_active and "D:ON" or "D:OFF"
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
    toggle_diagnostics = toggle_diagnostics,
}
