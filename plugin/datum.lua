vim.api.nvim_create_user_command( "Datum", function()
    local config = require("datum.config")
    print(config.options.dir)
end, {})
