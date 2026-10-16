local M = {}

M.notes_dir = function()
    local config = require("datum.config")
    local dir = vim.fn.expand(config.options.dir)
    return dir
end

M.note_path = function(slug)
    local path = vim.fs.joinpath(M.notes_dir(), slug .. ".tex")
    return path
end

return M
