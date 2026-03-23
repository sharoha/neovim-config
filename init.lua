local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy" .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
    "mason-org/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
})

-- some keybindings
-- lsp,
vim.g.mapleader = " "

vim.g.maplocalleader = " "

vim.o.clipboard = "unnamedplus"
vim.opt.path:append '**'

vim.keymap.set("n", "<leader>sl", "<cmd>:luafile %<CR>")
print("reloaded file")
-- make sure to have nvim-lspconfig(has the list of lsp configurations file), check their github
require("mason").setup()

-- used for mangaging lspconfig downlowad using mason
require("mason-lspconfig").setup()

-- used for managing auto download using mason annd is able to differenciate between lsp and linter
require("mason-tool-installer").setup({
    ensure_installed = { "lua_ls", "stylua", "kotlin-lsp" },
})

require("blink.cmp").setup({
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = 'lua'}
})


