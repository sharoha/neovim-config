local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/kotlin-lsp"
local cmd = vim.fn.executable(mason_bin) == 1 and mason_bin or "kotlin-lsp"

return {
    cmd = { cmd, "--stdio" },
    --    cmd = vim.lsp.rpc.connect("127.0.0.1", 9999),
    single_file_support = true,
    filetypes = { "kotlin" },
    root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
}
