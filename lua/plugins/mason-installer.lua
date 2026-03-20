return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = function()
        local servers = require("setup.lsp_servers")

        local ensure_installed = {
            "stylua",
            "ormolu",
        }

        local seen = {}
        for _, tool in ipairs(ensure_installed) do
            seen[tool] = true
        end

        for server_name in pairs(servers or {}) do
            if not seen[server_name] then
                table.insert(ensure_installed, server_name)
                seen[server_name] = true
            end
        end

        return {
            ensure_installed = ensure_installed,
            run_on_start = true,
        }
    end,
}
