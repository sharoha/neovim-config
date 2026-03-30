return {
    "sharoha/jvm-test-runner.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("jvm-test-runner").setup({})
    end,
}
