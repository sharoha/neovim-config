return {
    dir = "/Users/sharoha/Desktop/projects/nvim-jdk-test-runner",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("jdk_test_runner").setup()
    end,
}
