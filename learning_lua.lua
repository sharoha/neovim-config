-- Call a funciton on a buffer(in this example 4 is the buffer number of a kotlin class that i am experimeting with.
vim.api.nvim_buf_call(4, function()
    print("Now in buffer", vim.api.nvim_get_current_buf())

    -- this method can be used to get the active lsp client on this buffer
    local client = vim.lsp.get_clients({ buffer = 4 })

    -- can be used to print a table, but need a good way to print it as a json document that can be inspected locally, as the output gets printed in a less screen
    print(vim.inspect(client))
end)
