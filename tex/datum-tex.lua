local M = {}

M.embed = function(target)
    local dot = target:find(".", 1, true)
    if not dot then
        tex.error("datum: bad embed target '" .. target .. "'")
        return
    end
    local slug = (target):sub(1, dot-1)
    local card = (target):sub(dot+1)
    tex.sprint("[slug: " .. slug .. ", card: " .. card .. "]")
end

return M
