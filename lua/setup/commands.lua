vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
    desc = "Try to enable tree-sitter syntax highlighting",
    pattern = "*", -- run on *all* filetypes
    callback = function()
        pcall(function()
            vim.treesitter.start()
        end)
    end,
})
