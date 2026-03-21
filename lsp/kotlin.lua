local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/kotlin-lsp"
local cmd = vim.fn.executable(mason_bin) == 1 and mason_bin or "kotlin-lsp"

return {
    cmd = { cmd },
    single_file_support = true,
    filetypes = { "kotlin" },
    root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
}
