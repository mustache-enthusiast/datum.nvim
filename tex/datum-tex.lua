local M = {}
M.depth = 0
M.max_depth = 1

M.build_cards = function()
    M.cards = {}
    local dir = lfs.currentdir()
    for name in lfs.dir(dir) do
        local slug = name:match("^(.*)%.tex$")
        if slug then
            local path = dir .. "/" .. slug .. ".tex"
            local file = io.open(path, "r")
            if file then
                for line in file:lines() do
                    local id = line:match("\\begin{card}.-{(d:%w+)}")
                    if id then
                        M.cards[id] = slug
                    end
                end
            file:close()
            end
        end
    end
    for id, slug in pairs(M.cards) do
        texio.write_nl("datum cards: " .. id .. " -> " .. slug)
    end
end

M.find_card = function(id)
    if not M.cards then
        M.build_cards()
    end
    return M.cards[id]
end

M.embed = function(target)
    local slug = M.find_card(target)
    if not slug then
        tex.error("datum: card '" .. target .. "' not found")
        return
    end
    if M.depth >= M.max_depth then
        tex.sprint("\\dref{" .. slug .. "}")
        return
    end
    local path = lfs.currentdir() .. "/" .. slug .. ".tex"
    local file = io.open(path, "r")
    if not file then
        tex.error("datum: unable to open slug '" .. path .. "'")
        return
    end
    local lines = {}
    local inside = false
    local title = nil
    for line in file:lines() do
        if not title then
            title = line:match("\\title{(.*)}")
        end
        if not inside and line:find("\\begin{card}", 1, true) and line:find("{" .. target .. "}", 1, true) then
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
        tex.error("datum: card '" .. target .. "' in '" .. path .."' is not found")
        return
    end
    tex.print("\\DatumEmbedBegin{" .. slug .. "}{" .. title .. "}")
    tex.print(lines)
    tex.print("\\DatumEmbedEnd")
end

return M
