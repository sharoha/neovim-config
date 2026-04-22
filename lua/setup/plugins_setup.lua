vim.cmd([[colorscheme tokyonight]])

require("oil").setup({
    default_file_explorer = true,
})

require("mini.files").setup({})
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
-- neovim auto install some parsers: lua, vim, markdown, c,
-- So for automation for others we need nvim-treesitter
local ts = require("nvim-treesitter")
local already_installed = ts.get_installed()
local ensure_installed = { "kotlin", "java" }

local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

if #to_install > 0 then
    ts.install(to_install)
end
