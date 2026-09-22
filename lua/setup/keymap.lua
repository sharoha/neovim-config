vim.keymap.set(
    "n",
    "-",
    "<CMD>lua MiniFiles.open()<CR>",
    { desc = "Open Current directory in MiniFiles" }
)

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

-- conform
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- neogit

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })

vim.keymap.set("n", "<leader>fb", "<cmd>:ls<cr>:b<space>")
vim.keymap.set("n", "<leader>st", builtin.git_files, { desc = "[ ] Find buffers]" })

vim.keymap.set("n", "<leader>su", builtin.autocommands, { desc = "[ ] Find buffers]" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without losing register" })

-- Handling terminal open and close
local function find_terminal_buffer()
    local ids = vim.api.nvim_list_bufs()
    for _, id in ipairs(ids) do
        local buf_name = vim.api.nvim_buf_get_name(id)
        if vim.fn.match(buf_name, "zsh") > 0 then
            return id
        end
    end
    return -1
end

local function is_displayed(buf_id)
    local windows = vim.fn.getbufinfo(buf_id)[1].windows
    return #windows > 0
end

local function show_terminal(buf_id)
    vim.cmd("botright split")
    vim.cmd("resize " .. math.floor(vim.o.lines * 0.3))
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf_id)
end

local function hide_terminal(buf_id)
    local info = vim.fn.getbufinfo(buf_id)[1]
    if #info.windows > 0 then
        vim.api.nvim_win_close(info.windows[1], false)
    end
end
local function create_terminal_buffer()
    vim.cmd("botright split")
    vim.cmd("resize " .. math.floor(vim.o.lines * 0.3))
    vim.cmd("terminal")
end
vim.keymap.set("n", "<leader>t", function()
    local zsh_buf_id = find_terminal_buffer()
    if zsh_buf_id == -1 then
        create_terminal_buffer()
        return
    end
    if is_displayed(zsh_buf_id) then
        hide_terminal(zsh_buf_id)
    else
        show_terminal(zsh_buf_id)
    end
end, { desc = "open terminal below at 30% height" })
