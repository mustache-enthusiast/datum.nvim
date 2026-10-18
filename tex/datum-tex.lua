local M = {}

M.embed = function(target)
    local dot = target:find(".", 1, true)
    if not dot then
        tex.error("datum: bad embed target '" .. target .. "'")
        return
    end
    local slug = target:sub(1, dot-1)
    local card = target:sub(dot+1)
    local path = lfs.currentdir() .. "/" .. slug .. ".tex"
    local file = io.open(path, "r")
    if not file then
        tex.error("datum: unable to open slug '" .. path .. "'")
        return
    end
    local lines = {}
    local inside = false
    for line in file:lines() do
        if not inside and line:find("\\begin{card}", 1, true) and line:find("{" .. card .. "}", 1, true) then
            inside = true
        end
        if inside then
            table.insert(lines, line)
        end
        if inside and line:find("\\end{card}", 1, true) then
            break
        end
    end
    file:close()
    if #lines == 0 then
        tex.error("datum: card '" .. card .. "' in '" .. path .."' is not found")
        return
    end
    tex.print(lines)
end

return M
