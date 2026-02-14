require "nvchad.options"

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = false

-- Line
o.textwidth = 89
o.colorcolumn = "80"

-- Numbers
o.relativenumber = true

-- Fold
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
