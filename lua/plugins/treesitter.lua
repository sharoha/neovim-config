return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	--	main = 'nvim-treesitter.configs',
	opts = {
		ensure_installed = {
			"java",
			"kotlin",
			"haskell",
			"lua",
			"vim",
			"yaml",
			"markdown",
			"vimdoc",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
	},
}
