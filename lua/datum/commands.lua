local M = {}

M.dir = function()
    local config = require("datum.config")
    print(config.options.dir)
end

M.new = function()
    require("datum.new").run()
end

M.edit = function()
    require("datum.edit").run()
end

M.card = function()
    require("datum.card").run()
end

return M
