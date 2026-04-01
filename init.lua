require("setup.vimsetup")

local gh = function(plug)
    return "https://github.com/" .. plug
end

vim.pack.add({
    gh("mason-org/mason.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("saghen/blink.cmp"),
    gh("folke/which-key.nvim"),
    -- telescope

    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope-fzf-native.nvim"),
    -- oil
    gh("stevearc/oil.nvim"),

    gh("stevearc/conform.nvim"),
    gh("nvim-tree/nvim-web-devicons"),

    gh("NeogitOrg/neogit"),

    gh("nvim-treesitter/nvim-treesitter"),

    gh("sharoha/jvm-test-runner.nvim"),
})

require("oil").setup({
    default_file_explorer = true,
})

require("jvm-test-runner").setup({})

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

-- treesitter - seems like this does not have any behavior update
--require("nvim-treesitter.config").setup({
--    ensure_installed = {
--        "java",
--        "kotlin",
--        "haskell",
--        "lua",
--        "vim",
--        "yaml",
--        "markdown",
--        "vimdoc",
--    },
--    auto_install = true,
--    highlight = {
--        enable = true,
--    },
--    indent = { enable = true },
--})
require("setup.keymap")
require("setup.commands")
require("setup.lsp")
