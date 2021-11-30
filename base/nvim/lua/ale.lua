-- ======================
-- ALE
-- ======================
local g = vim.g
g.ale_html_htmlhint_executable = 'npx htmlhint'
g.ale_linters = {
  python={'flake8', 'pydocstyle'},
  javascript={'xo'},
  html={'htmlhint'},
  rust={'cargo'},
  haskell={'hlint'},
}
g.ale_fixers = {
   ['*']={'remove_trailing_lines', 'trim_whitespace'},
   python= {'black', 'isort'},
   r= {'styler'},
   javascript= {'prettier'},
   css= {'prettier'},
   html={'prettier'},
   rust= {'rustfmt'},
   haskell={'ormolu'}
}
-- Set this variable to 1 to fix files when you save them.
g.ale_fix_on_save = 1
-- keybindings
vim.api.nvim_set_keymap('n', '<C-k>', '<Plug>(ale_previous_wrap)', {silent=true})
vim.api.nvim_set_keymap('n', '<C-j>', '<Plug>(ale_next_wrap)', {silent=true})
-- Keep sign gutter open even if no errors
g.ale_sign_column_always = 1
