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

M.index = function()
    local index = require("datum.index")
    local issued_ids = require("datum.card").issued_ids()
    index.build()
    print(vim.inspect(index.files))
    print(vim.inspect(index.cards))
    print(vim.inspect(issued_ids))
end

M.index_nobuild = function()
    local index = require("datum.index")
    local issued_ids = require("datum.card").issued_ids()
    print(vim.inspect(index.files))
    print(vim.inspect(index.cards))
    print(vim.inspect(issued_ids))
end

M.embed = function()
    require("datum.picker").embed()
end

return M
