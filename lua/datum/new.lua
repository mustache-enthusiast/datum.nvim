local M = {}



M.run = function()
    vim.ui.input({prompt = "Slug: "}, function(input)
        if input == nil or input == "" then
            return
        end
        local paths = require("datum.paths")
        local path = paths.note_path(input)
        if vim.uv.fs_stat(path) then
            vim.notify("Datum: file '" .. path .. "' already exists", vim.log.levels.ERROR)
            return
        end
        vim.fn.mkdir(paths.notes_dir(), "p")
        local lines = {
            "\\documentclass{homeworkbase}",
            "\\usepackage{datum}",
            "\\datum{" .. input .. "}",
            "\\title{}",
            "\\tags{}",
            "\\begin{document}",
            "",
            "\\end{document}",
        }
        vim.fn.writefile(lines, path)
        vim.cmd.edit(path)
    end)
end

return M
