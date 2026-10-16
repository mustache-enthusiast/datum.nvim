local M = {}



M.run = function()
    vim.ui.input({prompt = "Slug: "}, function(input)
        if input == nil or input == "" then
            return
        end
        local config = require("datum.config")
        local dir = vim.fn.expand(config.options.dir)
        local path = vim.fs.joinpath(dir, input .. ".tex")
        if vim.uv.fs_stat(path) then
            vim.notify("Datum: file '" .. path .. "' already exists", vim.log.levels.ERROR)
            return
        end
        vim.fn.mkdir(dir, "p")
        local lines = {
            "\\documentclass{datum}",
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
