local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    solidity = { "solhint" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

-- lint.linters.solhint.args = {
--     "imports",
-- }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
