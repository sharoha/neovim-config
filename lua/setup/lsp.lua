vim.lsp.enable({ "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        print(
            string.format(
                "LspAttach fired for %s (buf %d)",
                vim.lsp.get_client_by_id(ev.data.client_id).name,
                ev.buf
            )
        )
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- Diagnostics
vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true

    -- Alternatively, customize specific options
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})
