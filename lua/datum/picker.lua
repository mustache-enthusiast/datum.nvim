local M = {}

M.card_items = function()
    local index = require("datum.index")
    local items = {}
    for id, card in pairs(index.cards) do
        local title = index.files[card.slug].title
        local card_content = table.concat(card.lines or {}, " ")
        table.insert(items, { id = id, title = title, card_content = card_content})
    end
    return items
end

M.embed = function()
    local items = M.card_items()
    if not items then
        vim.notify("Datum: no card entries in list.", vim.log.levels.ERROR)
        return
    end
    vim.ui.select(items, {
        prompt = "Available cards: ", 
        format_item = function(item)
            return item.title .. ": ".. item.card_content
        end,
    }, function(choice)
        if not choice then
            return
        end
        vim.api.nvim_put({"\\dembed{" .. choice.id .. "}"}, "c", true, true)
    end)
end

return M
