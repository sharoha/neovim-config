vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- GUI-launched Neovim on macOS often misses user shell PATH entries.
-- Add common bin directories early so external tools like tree-sitter are found.
do
    local sep = package.config:sub(1, 1) == "\\" and ";" or ":"
    local current_path = vim.env.PATH or ""
    local seen = {}

    for entry in string.gmatch(current_path, "([^" .. sep .. "]+)") do
        seen[entry] = true
    end

    local extra_paths = {
        vim.fn.expand("~/.cargo/bin"),
        vim.fn.expand("~/.local/bin"),
        vim.fn.expand("~/bin"),
        vim.fn.expand("~/.npm-global/bin"),
        vim.fn.expand("~/Library/pnpm"),
        "/opt/homebrew/bin",
        "/usr/local/bin",
    }

    for _, path in ipairs(extra_paths) do
        if vim.fn.isdirectory(path) == 1 and not seen[path] then
            current_path = path .. sep .. current_path
            seen[path] = true
        end
    end

    vim.env.PATH = current_path
end

-- vim.g.have_nerd_font = true
vim.opt.swapfile = false

vim.o.termguicolors = true

vim.o.number = true

vim.o.relativenumber = true

-- vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true

vim.opt.path:append("**")

vim.opt.wildignore:append({
    "*/.git/*",
    "*/build/*",
    "*/dist/*",
    "*/node_modules/*",
})
