local gh = function(plug)
    return "https://github.com/" .. plug
end

vim.pack.add({
    gh("mason-org/mason.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("saghen/blink.cmp"),
    gh("folke/which-key.nvim"),
    -- telescope

    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope-fzf-native.nvim"),
    -- oil
    gh("stevearc/oil.nvim"),
    gh("stevearc/conform.nvim"),
    gh("nvim-tree/nvim-web-devicons"),

    gh("NeogitOrg/neogit"),

    gh("nvim-treesitter/nvim-treesitter"),

    gh("sharoha/jvm-test-runner.nvim"),

    gh("folke/tokyonight.nvim"),
})

require("setup.vimsetup")
require("setup.plugins_setup")
require("setup.keymap")
require("setup.commands")
require("setup.lsp")
