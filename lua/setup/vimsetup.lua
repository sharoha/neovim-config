vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.g.have_nerd_font = true
vim.opt.swapfile = false

vim.o.number = true

vim.o.relativenumber = true

-- vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true
