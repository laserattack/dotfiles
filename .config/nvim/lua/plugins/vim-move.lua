return {
    "matze/vim-move",
    keys = {
        -- Normal mode
        { "K", "<Plug>MoveLineUp", mode = "n" },
        { "H", "<Plug>MoveCharLeft", mode = "n" },
        { "J", "<Plug>MoveLineDown", mode = "n" },
        { "L", "<Plug>MoveCharRight", mode = "n" },

        -- Visual mode
        { "K", "<Plug>MoveBlockUp", mode = "v" },
        { "J", "<Plug>MoveBlockDown", mode = "v" },
        { "H", "<Plug>MoveBlockLeft", mode = "v" },
        { "L", "<Plug>MoveBlockRight", mode = "v" },
    }
}
