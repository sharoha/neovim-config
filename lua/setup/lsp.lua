-- lsp,
-- make sure to have nvim-lspconfig(has the list of lsp configurations file), check their github
require("mason").setup()

-- used for mangaging lspconfig downlowad using mason
require("mason-lspconfig").setup()

-- used for managing auto download using mason annd is able to differenciate between lsp and linter
require("mason-tool-installer").setup({
    ensure_installed = { "lua_ls", "stylua", "prettierd", "ktlint", "kotlin-lsp" },
})

require("blink.cmp").setup({
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "lua" },
})
