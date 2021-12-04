require('telescope').setup{}

-- standard commands
vim.api.nvim_set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", {silent=true, noremap=true})
