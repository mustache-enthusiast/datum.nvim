local M = {}

M.dir = function()
    local config = require("datum.config")
    print(config.options.dir)
end

M.new = function()
    require("datum.new").run()
end

return M
