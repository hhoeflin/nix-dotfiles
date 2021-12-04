require('telescope').setup{}

-- standard commands
vim.api.nvim_set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>fe", ":lua require('telescope.builtin').file_browser()<cr>", {silent=true, noremap=true})

-- LSP
vim.api.nvim_set_keymap("n", "<leader>lre", ":lua require('telescope.builtin').lsp_references()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lds", ":lua require('telescope.builtin').lsp_document_symbols()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lws", ":lua require('telescope.builtin').lsp_workspace_symbols()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lys", ":lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lca", ":lua require('telescope.builtin').lsp_code_actions()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lra", ":lua require('telescope.builtin').lsp_range_code_actions()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>ldd", ":lua require('telescope.builtin').lsp_document_diagnostics()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lwd", ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>li", ":lua require('telescope.builtin').lsp_implementations()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>lde", ":lua require('telescope.builtin').lsp_definitions()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>ltd", ":lua require('telescope.builtin').lsp_type_definitions()<cr>", {silent=true, noremap=true})
