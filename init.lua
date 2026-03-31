require("setup.vimsetup")

vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/folke/which-key.nvim",
    -- telescope

    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    -- oil
    "https://github.com/stevearc/oil.nvim",

    "https://github.com/stevearc/conform.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    "https://github.com/NeogitOrg/neogit",

    "https://github.com/nvim-treesitter/nvim-treesitter",
})

require("oil").setup({
    default_file_explorer = true,
})

-- setit up for this plugin setup
--return {
--    "sharoha/jvm-test-runner.nvim",
--
--
--    config = function()
--        require("jvm-test-runner").setup({})
--    end,
--}
local function setup_conform()
    require("conform").setup({
        formatters_by_ft = {
            haskell = { "ormolu" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            kotlin = { "ktlint" },
            json = { "prettierd" },
        },
    })
end

setup_conform()

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        require("conform").format({
            bufnr = args.buf,
            async = false,
            lsp_format = "fallback",
        })
    end,
}) --
-- telescope
require("telescope").setup({
    defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git/" },
    },
})
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- treesitter
require("nvim-treesitter.config").setup({
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
})
require("setup.keymap")
require("setup.commands")
require("setup.lsp")
