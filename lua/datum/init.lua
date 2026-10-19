local config = require("datum.config")

local M = {}

function M.setup(opts)
    config.setup(opts)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("datum", { clear = true }),
        pattern = require("datum.paths").notes_dir() .. "/*.tex",
        callback = function()
            require("datum.index").build()
        end,
    })
    require("datum.index").build()
end

return M
