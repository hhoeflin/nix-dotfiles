-- general settings
require('settings')

-- lualine
require('lualine').setup()

-- startify screen
local alpha = require'alpha'
local startify = require'alpha.themes.startify'
startify.nvim_web_devicons.enabled = false
alpha.setup(startify.opts)

-- ale
require('ale')

-- bufstop
vim.api.nvim_set_keymap('n', '<leader>b', ':BufstopFast<CR>', {silent=true, noremap=true})

-- nvim-tree
require('nvim-tree').setup({
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  }
})
local map = vim.api.nvim_set_keymap
map('n', '<C-p>', ':NvimTreeToggle <CR>', {noremap=true;})

-- lsp
require('lsp_compe')
