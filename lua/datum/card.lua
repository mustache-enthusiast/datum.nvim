local M = {}

M.generate = function()
    local id = "d:"
    local alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    math.randomseed(os.time() + vim.fn.getpid())
    for i = 1, 4 do
        local n = math.random(#alphabet)
        local char = alphabet:sub(n, n)
        id = id .. char
    end
    return id
end


M.run = function()
    vim.api.nvim_put({ M.generate() }, "c", true, true)
end

return M
