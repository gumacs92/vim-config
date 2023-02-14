local capabilities = require("cmp_nvim_lsp").default_capabilities()

local languageConfigs = {
    typescript = {
        lsp = {"tsserver"}
    },
    vim = {
        lsp = {"vimls"}
    },
    lua = {
        lsp = {"sumneko_lua" }
    },
    vue = {
        lsp = {"volar"}
    },
    php = {
        lsp = {"intelephense"}
    },
    html = {
        lsp = {"html"}
    },
    css = {
        lsp = {'cssls', 'tailwindcss'}
    }
}

local treesitterConfig = {}
local lspConfig = {}
for lang, config in pairs(languageConfigs) do
    for _, lspServer in ipairs(config.lsp) do
        print(lspServer)
        table.insert(lspConfig, lspServer)
    end
    table.insert(treesitterConfig, lang)
end


vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

require"general-config/init".setup()
require"formatter-config/init".setup()
require"autocomplete-config/init".setup()
require'lsp-config/init'.setup(lspConfig, capabilities)
require'treesitter-config/init'.setup(treesitterConfig)

print "Sourced init.lua"
