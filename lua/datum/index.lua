local M = {}

M.build = function ()
    M.files = {}
    M.cards = {}
    local paths = require("datum.paths")
    local dir = paths.notes_dir()
    for name in vim.fs.dir(dir) do
        local slug = name:match("^(.*)%.tex$")
        if slug then
            local path = paths.note_path(slug)
            local title
            local lines = vim.fn.readfile(path)
            for i, line in ipairs(lines) do
                local id = line:match("\\begin{card}.-{(d:%w+)}")
                if not title then
                    title = line:match("\\title{(.*)}")
                end
                if id then
                    M.cards[id] = { slug = slug, line = i }
                end
            end
            if title == nil or title == "" then
                title = slug
            end
            M.files[slug] = { path = path, title = title }
        end
    end
end

return M



            


