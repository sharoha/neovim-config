vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Current directory in Oil" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!<CR>')

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>sl", "<cmd>:luafile %<CR>", { desc = "Reload the current lua file" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S] Find files]" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[G]rep across files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find buffers]" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch neovim config" })

-- for terminal
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>", { desc = "[T]erminal mode exit to normal mode" })
