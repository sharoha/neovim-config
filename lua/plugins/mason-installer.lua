return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            "stylua",
            "ormolu",
	    "lua-language-server"
        },
        run_on_start = true,
    },
}
