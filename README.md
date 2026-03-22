# Neovim Config Overview

## Layout
- `init.lua` – entrypoint; loads `setup/` and plugins via lazy.nvim.
- `lua/setup/` – core settings (`vimsetup.lua`), keymaps, commands, LSP bootstrap (`lsp.lua`).
- `lua/plugins/` – lazy.nvim plugin specs (Mason, Treesitter, Telescope, etc.).
- `lsp/` – per-server LSP configs Neovim 0.11 auto-loads (e.g. `lsp/lua_ls.lua`).

## LSP setup
- This config uses Neovim 0.11's built-in LSP support with per-server configs in `lsp/`.
- Mason installs tools on startup through `lua/plugins/mason-installer.lua`.
- The currently enabled servers are `lua_ls` and `kotlin` from `lua/setup/lsp.lua`.

### Current server configs
- `lsp/lua_ls.lua`
  - Uses Mason's `lua-language-server` binary when available.
  - Sets `filetypes = { "lua" }`.
  - Uses `.luarc.json`, `.luarc.jsonc`, or `.git` as root markers.
  - Configures `LuaJIT` runtime and treats `vim` as a global.
- `lsp/kotlin.lua`
  - Uses Mason's `kotlin-lsp` binary with `--stdio`.
  - Sets `filetypes = { "kotlin" }`.
  - Enables `single_file_support = true`.
  - Uses `build.gradle`, `build.gradle.kts`, or `pom.xml` as root markers.

### Add a new server
1) Add the Mason package name to `ensure_installed` in `lua/plugins/mason-installer.lua`.
2) Create `lsp/<server>.lua` returning the server options table. Example:
   ```lua
   local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/lua-language-server"
   local cmd = vim.fn.executable(mason_bin) == 1 and mason_bin or "lua-language-server"

   return {
     cmd = { cmd },
     filetypes = { "lua" },
     root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
   }
   ```
3) Add the config name to the `servers` table in `lua/setup/lsp.lua`:
   ```lua
   local servers = { "lua_ls", "kotlin", "<server>" }
   vim.lsp.enable(servers)
   ```
4) Restart Neovim and open a matching filetype to attach the server.

## Notes
- On `LspAttach`, built-in completion is enabled for clients that support `textDocument/completion`, with `autotrigger = true`.
- Diagnostics virtual lines are enabled only for the current cursor line in `lua/setup/lsp.lua`.
