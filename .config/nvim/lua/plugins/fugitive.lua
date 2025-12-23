return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
    vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
    vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
  end
}
