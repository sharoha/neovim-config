-- Add new LSP server names here; Neovim 0.11 will load configs from lsp/<name>.lua
local servers = { "lua_ls", "kotlin" }

-- local servers = { "lua_ls" }
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/implementation") then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end
        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
--vim.api.nvim_create_autocmd("LspAttach", {
--    callback = function(ev)
--        print(
--            string.format(
--                "LspAttach fired for %s (buf %d)",
--                vim.lsp.get_client_by_id(ev.data.client_id).name,
--                ev.buf
--            )
--        )
--        local client = vim.lsp.get_client_by_id(ev.data.client_id)
--        if client:supports_method("textDocument/completion") then
--            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
--            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--        end
--    end,
--})

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
