# Neovim Config Overview

## Layout
- `init.lua` – entrypoint; loads `setup/` and plugins via lazy.nvim.
- `lua/setup/` – core settings (`vimsetup.lua`), keymaps, commands, LSP bootstrap (`lsp.lua`).
- `lua/plugins/` – lazy.nvim plugin specs (Mason, Treesitter, Telescope, etc.).
- `lsp/` – per-server LSP configs Neovim 0.11 auto-loads (e.g. `lsp/lua_ls.lua`).

## LSP setup (no extra plugins)
1) Make sure Mason has the server binary:
   - Add the server name to `ensure_installed` in `lua/plugins/mason-installer.lua` (e.g. `"lua-language-server"`).
   - Run `:Mason` or `:MasonInstall <server>` to install.
2) Create a config file `lsp/<server>.lua` returning the server options table. Example for Lua:
   ```lua
   -- lsp/lua_ls.lua
   local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/lua-language-server"
   local cmd = vim.fn.executable(mason_bin) == 1 and mason_bin or "lua-language-server"
   return {
     cmd = { cmd },
     filetypes = { "lua" },
     root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
   }
   ```
3) Register the server in `lua/setup/lsp.lua` by adding it to the `servers` table:
   ```lua
   local servers = { "lua_ls", "tsserver" }
   vim.lsp.enable(servers)
   ```
4) Restart Neovim (or `:source init.lua`) and open a file of that type; `LspAttach` should fire.

## Notes
- Neovim 0.11 auto-detects server configs from the `lsp/` directory on `runtimepath`; no extra LSP plugin is used.
- Diagnostics virtual lines are enabled only on the current line (see `lua/setup/lsp.lua`).
