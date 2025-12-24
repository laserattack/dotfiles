-- inspired by: https://github.com/radleylewis/nvim-lite suckless NeoVim Config

-- ============================================================================
-- BASE SETTINGS
-- ============================================================================

vim.o.termguicolors = true
vim.o.list          = true
vim.o.listchars     = "trail:·,lead:·,tab:»\\ "
vim.g.mapleader     = " "
vim.opt.updatetime  = 300

-- disable swap
vim.o.swapfile = false

-- tabs
vim.o.expandtab   = true  -- tabs to spaces
vim.o.shiftwidth  = 4     -- shift = 4 spaces
vim.o.tabstop     = 4     -- tab = 4 spaces
vim.o.smarttab    = true
vim.o.autoindent  = true
vim.o.smartindent = true

-- search
vim.o.ignorecase = true
vim.o.smartcase  = true -- case-sensitive if uppercase used
vim.o.hlsearch   = false
vim.o.incsearch  = true -- shows a match as you type search query

-- clipboard
vim.o.clipboard = "unnamedplus"

-- cursor
vim.o.guicursor     = "a:block"
vim.opt.cursorline  = true
vim.o.cursorlineopt = "both"

-- line numbers
vim.o.number         = true
vim.o.relativenumber = true

-- line wraps
vim.o.wrap = false

-- ============================================================================
-- KEY BINDS
-- ============================================================================

-- quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })

-- move lines & selection
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Move the selected block to the right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Move the selected block to the left" })

-- screen center when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- splitting & resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- work with buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete (close) current buffer" })

-- delete & paste without yanking
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

-- other
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = "Delete word after cursor" })
vim.keymap.set('n', '<leader>w', function() vim.opt.wrap = not vim.opt.wrap:get() end, { desc = "Toggle line wrap mode" })
vim.keymap.set('n', 'cd', ':lcd %:p:h<CR>', { desc = "Change working directory to current file directory" })
vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })

-- ============================================================================
-- AUTO COMMANDS
-- ============================================================================

-- automatic switch to us keyboard layout in insert mode
vim.api.nvim_create_autocmd({
    "InsertLeave",
    "CmdlineLeave",
    "TermLeave",
    "VimEnter",
}, {
    callback = function()
        vim.fn.system("xkb-switch -s us")
    end,
})

-- netrw mappings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "<Esc>", ":bdelete<CR>", {
            buffer = true, -- local mapping only for this buffer
            desc = "Close netrw buffer",
            noremap = true,
            silent = true
        })
    end,
})

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function get_terminal_window_config()
    local ui = vim.api.nvim_list_uis()[1]
    local screen_width = ui.width
    local screen_height = ui.height
    local width = math.floor(screen_width * 0.7)
    local height = math.floor(screen_height * 0.7)
    
    return {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((screen_height - height) / 2),
        col = math.floor((screen_width - width) / 2),
        style = 'minimal',
        border = 'rounded',
    }
end

local function FloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
    end

    local win_config = get_terminal_window_config()
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, win_config)

    vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)
    vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight', 'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')
    
    vim.api.nvim_set_hl(0, 'FloatingTermNormal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'FloatingTermBorder', { bg = 'none' })

    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in ipairs(lines) do
        if line ~= '' then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv('SHELL'))
    end

    terminal_state.is_open = true
    vim.cmd('startinsert')

    vim.api.nvim_create_autocmd('BufLeave', {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end

local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

vim.keymap.set('n', '<leader>t', FloatingTerminal, { noremap = true, silent = true, desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<Esc>', function()
    if terminal_state.is_open then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = 'Close floating terminal from terminal mode' })

vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
        if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
            local win_config = get_terminal_window_config()
            vim.api.nvim_win_set_config(terminal_state.win, win_config)
        end
    end,
})

-- ============================================================================
-- PLUGINS
-- ============================================================================

-- setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins
require("lazy").setup({

    {
        -- colorscheme
        "xero/miasma.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme miasma")
        end
    },

    {
        -- smart moves
        "ggandor/leap.nvim",
        config = function()
            require("leap").setup({ preview = false })
            vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)', { desc = "Leap forward" })
            vim.keymap.set('n', 'S', '<Plug>(leap-from-window)', { desc = "Leap across windows" })
        end
    },

    {
        -- align
        'junegunn/vim-easy-align',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set({'n', 'x'}, 'ga', '<Plug>(EasyAlign)', { noremap = false, desc = "Align text around delimiter" })
        end
    },

    {
        -- automatic pair insertion for (, ", etc.
        'nvim-mini/mini.pairs',
        event = "InsertEnter",
        config = function()
            require('mini.pairs').setup()
        end
    },

    {
        -- treesitter
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "cpp", "lua", "zig", "python", "perl",
                    "go", "json", "html", "css", "javascript"
                },
                sync_install = true,
                auto_install = false,
                highlight = {
                    enable                            = true,
                    additional_vim_regex_highlighting = false,
                }
            })
        end
    },

    {
        -- git wrapper
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
            vim.keymap.set("n", "<leader>gl", ":Git log --oneline --graph --all<CR>", { desc = "Git log" })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "fugitive",
                callback = function()
                    vim.keymap.set("n", "gp", ":Git push<CR>", { buffer = true, desc = "Fugitive Git push" })
                end
            })
        end
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                keyword = "fg",
            },
        },
    },

    {
        -- telescope searcher
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            local telescope = require('telescope')
            local builtin   = require('telescope.builtin')
            local actions   = require('telescope.actions')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ['<Esc>'] = actions.close },
                        n = { ['<Esc>'] = actions.close },
                    },
                },
                pickers = {
                    find_files = {
                        previewer = false,
                        find_command = {
                            "rg", "--files", "--no-ignore",
                        },
                    },
                    live_grep = {
                        vimgrep_arguments = {
                            "rg",
                            "--no-ignore",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                        },
                    }
                },
            })

            vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Normal" })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
            vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "Normal" })

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find file" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope find content (grep)" })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope find keymap" })
            vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Telescope find in current buffer" })

            -- folke/todo-comments.nvim needed
            vim.keymap.set('n', '<leader>ft', ':TodoTelescope<CR>', { desc    = "Telescope find TODO comments" })
        end
    },

})
