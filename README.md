# Neovim Config Overview

## Layout
- `init.lua` bootstraps `lazy.nvim`, then loads setup modules.
- `lua/plugins/` contains plugin specs loaded by `lazy.nvim`.
- `lua/setup/` contains local config for editor behavior, keymaps, commands, and LSP.

## LSP Setup
This config no longer sources server definitions from the local `lsp/` directory.

LSP now relies on:
- `mason.nvim` for package management
- `mason-lspconfig.nvim` for bridging Mason packages to `nvim-lspconfig`
- `nvim-lspconfig` for server configurations
- `mason-tool-installer.nvim` for ensuring required tools are installed

The current setup lives in [lua/setup/lsp.lua](/Users/sharoha/.config/nvim/lua/setup/lsp.lua).

### What it does
- Calls `require("mason").setup()`
- Calls `require("mason-lspconfig").setup()`
- Calls `require("mason-tool-installer").setup()` with:
  - `lua_ls`
  - `stylua`
- Enables built-in LSP completion on `LspAttach` when the client supports `textDocument/completion`

### Add or change an LSP server
1. Add the server name to `ensure_installed` in [lua/setup/lsp.lua](/Users/sharoha/.config/nvim/lua/setup/lsp.lua).
2. Configure the server through `nvim-lspconfig`.
3. Restart Neovim and open a matching filetype to verify the server attaches.

### Notes
- `mason-tool-installer` can install both LSP servers and non-LSP tools, which is why `stylua` is managed in the same list.
- Completion is using Neovim's built-in LSP completion API, not a separate completion plugin.
