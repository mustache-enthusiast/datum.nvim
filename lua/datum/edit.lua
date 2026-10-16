local M = {}

M.run = function()
    vim.ui.input({prompt = "Slug: "}, function(input)
        if input == nil or input == "" then
            return
        end
        local paths = require("datum.paths")
        local path = paths.note_path(input)
        if not vim.uv.fs_stat(path) then
            vim.notify("Datum: file '" .. path .. "' does not exist", vim.log.levels.ERROR)
            return
        end
        vim.cmd.edit(path)
    end)
end

return M
