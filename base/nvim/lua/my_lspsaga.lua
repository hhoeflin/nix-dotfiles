local saga = require 'lspsaga'

-- change the lsp symbol kind
local kind = require('lspsaga.lspkind')
kind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

-- use default config
saga.init_lsp_saga()

-- lsp finder to find the cursor word definition and reference
vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { silent = true,noremap = true })

local action = require("lspsaga.codeaction")

-- code action
vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true,noremap = true })
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, { silent = true,noremap =true })

-- show hover doc and press twice will jumpto hover window
vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })

local action = require("lspsaga.action")
-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<C-f>", function()
    action.smart_scroll_with_saga(1)
end, { silent = true })
-- scroll up hover doc
vim.keymap.set("n", "<C-b>", function()
    action.smart_scroll_with_saga(-1)
end, { silent = true })


-- show signature help
vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true,noremap = true})

-- rename
vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, { silent = true,noremap = true })

-- preview definition
vim.keymap.set("n", "gd", require("lspsaga.definition").preview_definition, { silent = true,noremap = true })

-- jump and show diagnostics
vim.keymap.set("n", "<leader>cd", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true,noremap= true })

-- jump diagnostic
vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap =true })
vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, { silent = true, noremap =true })
-- or jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })
