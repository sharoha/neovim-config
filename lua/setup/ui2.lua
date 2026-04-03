-- Experimental UI2: floating cmdline and messages
vim.o.cmdheight = 0
require("vim._core.ui2").enable({
    enable = true,
    msg = {
        cmd = {
            height = 0.5,
        },
        dialog = {
            height = 0.5,
        },
        msg = {
            height = 0.3,
            timeout = 5000,
        },
        pager = {
            height = 0.5,
        },
    },
})
