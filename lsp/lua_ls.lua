local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/lua-language-server"
local cmd = vim.fn.executable(mason_bin) == 1 and mason_bin or "lua-language-server"

return {
    -- Prefer Mason's pinned binary; fall back to system install
    cmd = { cmd },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
