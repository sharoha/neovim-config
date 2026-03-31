return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "mason-org/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },
        config = function()
            require("setup.lsp")
        end,
    },
}
