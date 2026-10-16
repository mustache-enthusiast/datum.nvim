vim.api.nvim_create_user_command("Datum", function(opts)
    local commands = require("datum.commands")
    local fn = commands[opts.args]
    if fn then
        fn()
    else
        vim.notify("Datum: unknown subcommand '" .. opts.args .. "'", vim.log.levels.ERROR)
    end
end, { nargs = 1 })
