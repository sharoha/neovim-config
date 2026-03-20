return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = function()
        local ensure_installed = {
            "stylua",
            "ormolu",
        }

        return {
            ensure_installed = ensure_installed,
            run_on_start = true,
        }
    end,
}
