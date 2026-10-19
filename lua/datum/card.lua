local M = {}

local function raw_id()
    local id = "d:"
--    local alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    local alphabet = "a"
    math.randomseed(os.time() + vim.fn.getpid())
    for i = 1, 4 do
        local n = math.random(#alphabet)
        local char = alphabet:sub(n, n)
        id = id .. char
    end
    return id
end


M.run = function()
    local id = M.generate()
    if not id then
        return
    end
    vim.api.nvim_put({id}, "c", true, true)
end

M.generate = function ()
    local index = require("datum.index")
    if not index.cards then
        index.build()
    end
    local id = raw_id()
    local tries = 1
    while index.cards[id] do
        if tries >= 100 then
            vim.notify("Datum: could not generate a unique card id", vim.log.levels.ERROR)
            return nil
        end
        id = raw_id()
        tries = tries + 1
    end
    return id
end

return M
