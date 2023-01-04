-- Set global variables
vim.g.mapleader = " "

-- Set vim options
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.showmode = true
vim.o.hidden = true

vim.wo.cursorline = true
vim.wo.number = true

require('plugins')
