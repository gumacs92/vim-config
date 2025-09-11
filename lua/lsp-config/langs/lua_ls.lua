local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

M.lsp_config = {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                maxPreload = 2000,
                preloadFileSize = 1000,
                library = { vim.env.VIMRUNTIME, vim.fn.stdpath("config") .. "/lua" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

return M
