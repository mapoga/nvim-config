local lint = require "lint"

lint.linters_by_ft = {
    -- lua = { "luacheck" },
    -- python = { "flake8" },
}

-- lint.linters.luacheck.args = {
--     unpack(lint.linters.luacheck.args),
--     "--globals",
--     "love",
--     "vim",
-- }

-- lint.linters.flake8.args = {
--     unpack(lint.linters.flake8.args),
--     "--max-line-length",
--     "89",
--     "--extend-ignore",
--     "F401,E501",
-- }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
