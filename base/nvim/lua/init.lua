-- general settings
require('settings')

-- lualine
require('lualine').setup(
  {
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,  -- displays file status (readonly status, modified status)
          path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
          shorting_target = 40 -- Shortens path to leave 40 space in the window
                               -- for other components. Terrible name any suggestions?
        }
      }
    }
  }
)

-- startify screen
local alpha = require'alpha'
local startify = require'alpha.themes.startify'
startify.nvim_web_devicons.enabled = false
alpha.setup(startify.opts)

-- ale
require('ale')

-- bufstop
vim.api.nvim_set_keymap('n', '<leader>s', ':BufstopFast<CR>', {silent=true, noremap=true})

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

-- telescope
require('my_telescope')
