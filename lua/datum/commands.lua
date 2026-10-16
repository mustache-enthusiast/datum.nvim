local M = {}

M.dir = function()
    local config = require("datum.config")
    print(config.options.dir)
end

return M
