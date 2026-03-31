require("setup.vimsetup")
local github_pref = "https://github.com/"

vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/folke/which-key.nvim",
  -- telescope

--    "https://github.com/nvim-telescope/telescope.nvim",
--
--        "https://github.com/nvim-lua/plenary.nvim",
--"https://github.com/nvim-telescope/telescope-fzf-native.nvim"
})

local github = function(item) 
	return github_pref .. item
end

local hooks = function(ev) 
	print('lsp setup has been called')
require("setup.lsp")
end
vim.api.nvim_create_autocmd('PackChanged', {
	callback = hooks
})


--local pac = vim.pack.get()
--local names = vim.iter(pac)
--:map(function(x) return x.spec.name end)
--:totable()
--print(vim.inspect(pac))
--vim.pack.del(names)

--require("telescope").setup({
--            defaults = {
--                path_display = { "truncate" },
--                file_ignore_patterns = { "^.git/" },
--            },
--        })
--        pcall(require("telescope").load_extension, "fzf")
--        pcall(require("telescope").load_extension, "ui-select")
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy" .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)


require("lazy").setup("plugins")

require("setup.keymap")
require("setup.commands")
require("setup.lsp")
vim.cmd([[
   hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
]])
