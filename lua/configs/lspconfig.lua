local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
}

-- list of servers configured with default config.
local default_servers = { "html", "cssls", "tsserver", "tailwindcss", "eslint" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lspconfig.solidity_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "solidity" },
    root_dir = lspconfig.util.root_pattern("hardhat.config.*", "fonudry.*"),
})
-- lspconfig.solidity_ls_nomicfoundation.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "solidity" },
--     root_dir = lspconfig.util.root_pattern("hardhat.config.*", "fonudry.*"),
-- })
-- configuring single server, example: typescript
-- lspconfig.tsserver.setup({
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
-- })
