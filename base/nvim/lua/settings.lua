local g = vim.g
local set = vim.opt

-- setting the leader keys
g.mapleader = "\\"
g.maplocalleader = "-"

-- line numbers
set.nu = true

-- settings on tabstops
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- switch between windows using the window number
for i = 1, 9
do
  vim.api.nvim_set_keymap('n', '<Leader>' .. i, ":" .. i .. 'wincmd w<CR>', {silent=true, noremap=true})
end

-- theme
vim.cmd("colorscheme dracula")
