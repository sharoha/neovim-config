-- Call a funciton on a buffer(in this example 8 is the buffer number of a kotlin class that i am experimeting with.
-- order is important, so helper function needs to be defined first
local function clients_as_json(clients)
    local out = {}
    -- ipairs works here since get_clients returns a list, check the doc, :help get_clients
    for _, c in ipairs(clients) do
        out[#out + 1] = {
            id = c.id,
            name = c.name,
            root_dir = c.config.root_dir,
            initialized = c.initialized,
            offset_encoding = c.offset_encoding,
            capability = c.capabilities,
            commands = c.commands,
            config = c.config,
            -- adding back the following line will print the error "Failed to perform json encoding", since this is not a simple jsonable object
            --            dynamic_capability = c.dynamic_capabilities,
            flags = c.flags,
            commands_provider = c.server_capabilities.executeCommandProvider,
        }
    end
    return vim.json.encode(out) -- or vim.fn.json_encode(out)
end
vim.api.nvim_buf_call(8, function()
    local buf_num = 8
    print("Now in buffer", vim.api.nvim_get_current_buf())

    -- this method can be used to get the active lsp client on this buffer
    local clients = vim.lsp.get_clients({ buffer = buf_num })

    -- can be used to print a table, but need a good way to print it as a json document that can be inspected locally, as the output gets printed in a less screen
    --    print(vim.inspect(clients))
    --   dumpTable(client)
    local ok, json = pcall(clients_as_json, clients)
    --    print(ok and json or "Failed to perfom json encoding")
    local f = assert(io.open("out.json", "w"))
    f:write(json)
    f:close()

    -- now lets try to execute on capability that the kotlin lsp provides,
    -- its present in the commands_provider in the out.json
    local uri = vim.uri_from_bufnr(buf_num)
    clients[1]:request(
        "workspace/executeCommand",
        { command = "kotlin.organize.imports", arguments = { uri } },
        function(err, _)
            if err then
                vim.notify("Failed to organize imports: " .. vim.inspect(err), vim.log.levels.ERROR)
                return
            end
        end,
        8
    )
end)

-- seems like for kotlin project to recognize a intTest directory, following gradle configuration is required:
-- 
--val intTest by sourceSets.creating {
--	kotlin.srcDir("intTest/kotlin")
--	resources.srcDir("intTest/resources")
--
--	compileClasspath += sourceSets.main.get().output + configurations.testRuntimeClasspath.get()
--	runtimeClasspath += output + compileClasspath
--}
--
--configurations[intTest.implementationConfigurationName].extendsFrom(configurations.testImplementation.get())
--configurations[intTest.runtimeOnlyConfigurationName].extendsFrom(configurations.testRuntimeOnly.get())

--
-- for diagnostic remember this
-- These diagnostic keymaps are created unconditionally when Nvim starts:
--]d jumps to the next diagnostic in the buffer. ]d-default
--[d jumps to the previous diagnostic in the buffer. [d-default
--]D jumps to the last diagnostic in the buffer. ]D-default
--[D jumps to the first diagnostic in the buffer. [D-default
--<C-w>d shows diagnostic at cursor in a floating window. CTRL-W_d-defaultk
