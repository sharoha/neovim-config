-- lsp,
-- make sure to have nvim-lspconfig(has the list of lsp configurations file), check their github
require("mason").setup()

-- used for mangaging lspconfig downlowad using mason
require("mason-lspconfig").setup()

-- used for managing auto download using mason annd is able to differenciate between lsp and linter
require("mason-tool-installer").setup({
    ensure_installed = { "lua_ls", "stylua" },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
