local M = {}

M.defaults = {
    dir = "~/code/sandbox/datum",
}

M.options = {}

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
