local capabilities = require("cmp_nvim_lsp").default_capabilities()

local languageConfigs = {
    typescript = {
        lsp = {"tsserver"},
        linters = {"eslint"},
        formatters = {"prettier"}
    },
    vim = {
        lsp = {"vimls"}
    },
    lua = {
        lsp = {"lua_ls" }
    },
    vue = {
        lsp = {"volar", "eslint"}
    },
    svelte ={
        lsp = {"svelte"}
    },
    php = {
        lsp = {"intelephense"},
        linters = {"phpstan"},
        formatter = {"php-cs-fixer"}
    },
    html = {
        lsp = {"html"}
    },
    css = {
        lsp = {'cssls', 'tailwindcss'}
    },
    java = {
        lsp = {"jdtls"}
    },
    kotlin = {
        lsp = {"kotlin_language_server"}
    }
}

capabilities = {
    workspace = {
        didChangeWatchedFiles = {
            ddynamicRegistration = true
        }
    }
}

local treesitterConfig = {}
local lspConfig = {}
local nullLsconfig = {}
for lang, config in pairs(languageConfigs) do
    for _, lspServer in ipairs(config.lsp) do
        print(lspServer)
        table.insert(lspConfig, lspServer)
    end
    if config.formatters then
        for _, formatter in ipairs(config.formatters) do
            table.insert(nullLsconfig, formatter)
        end
    end
    if config.linters then
        for _, linter in ipairs(config.linters) do
            table.insert(nullLsconfig, linter)
        end
    end
    table.insert(treesitterConfig, lang)
end


vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     show_current_context = true,
--     -- show_current_context_start = false,
-- }

require'neovide-config/init'.setup()
require'theme-config/init'.setup()
require'treesitter-config/init'.setup(treesitterConfig)
require"general-config/init".setup()
-- require"formatter-config/init".setup()
require"autocomplete-config/init".setup()

require"mason".setup() -- This is the main plugin that allow us to install and configure language servers and formatters 
require'lsp-config/init'.setup(lspConfig, capabilities)
require'null-ls-config/init'.setup(nullLsconfig)

print "Sourced init.lua"
