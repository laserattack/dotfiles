return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveIndex",
      callback = function()
        vim.keymap.set("n", "gp", ":Git push<CR>", {
          buffer = 0,
          desc = "Git push"
        })
      end
    })
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "fugitive",
    --   callback = function()
    --     vim.keymap.set("n", "gp", ":Git push<CR>", {
    --       buffer = true,
    --       desc = "Git push" 
    --     })
    --   end
    -- })
  end
}
