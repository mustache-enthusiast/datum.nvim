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
            local card_id = nil
            local card_content = {}
            for i, line in ipairs(lines) do
                local id = line:match("\\begin{card}.-{(d:%w+)}")
                local end_card = line:match("\\end{card}")
                if not title then
                    title = line:match("\\title{(.*)}")
                end
                if end_card and card_id then
                    M.cards[card_id].lines = card_content
                    M.cards[card_id].end_line = i
                    card_id = nil
                end
                if card_id then
                    table.insert(card_content, line)
                end
                if id then
                    M.cards[id] = { slug = slug, line = i }
                    card_id = id
                    card_content = {}
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



            


