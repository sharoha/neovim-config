require("setup.vimsetup")
local github_pref = "https://github.com/"
vim.pack.add({
    github_pref .. "mason-org/mason.nvim",
    github_pref .. "WhoIsSethDaniel/mason-tool-installer.nvim",
    github_pref .. "mason-org/mason-lspconfig.nvim",
    github_pref .. "neovim/nvim-lspconfig",
    github_pref .. "saghen/blink.cmp",
    github_pref .. "folke/which-key.nvim",
})

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


require("lazy").setup("plugins")

require("setup.keymap")
require("setup.commands")
require("setup.lsp")
vim.cmd([[
   hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
]])
