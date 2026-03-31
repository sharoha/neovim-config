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
})

require("oil").setup({
    default_file_explorer = true,
})

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

--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--if not (vim.uv or vim.loop).fs_stat(lazypath) then
--    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--    local out = vim.fn.system({
--        "git",
--        "clone",
--        "--filter=blob:none",
--        "--branch=stable",
--        lazyrepo,
--        lazypath,
--    })
--    if vim.v.shell_error ~= 0 then
--        error("Error cloning lazy" .. out)
--    end
--end
--
-----@type vim.Option
--local rtp = vim.opt.rtp
--rtp:prepend(lazypath)
--

--require("lazy").setup("plugins")

require("setup.keymap")
require("setup.commands")
require("setup.lsp")
