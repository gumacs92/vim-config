function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match('^user') and not name:match('nvim-tree') then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.api.nvim_set_keymap("n", "<leader><leader><CR>", '<cmd>lua ReloadConfig()<CR>', { noremap = true, silent = true })

require 'mappings'.setup()
require 'plugins'.setup()
require 'autocommands'.setup()


local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local wk = require("which-key")
-- wk.setup {}
--
--

-- resourece configuraion
vim.api.nvim_set_keymap("n", "<leader><leader><CR>", '<cmd>lua ReloadConfig()<CR>', { noremap = true, silent = true })

_G.formatCode = function()
    vim.lsp.buf.format({
        timeout_ms = 15000,
        filter = function(client)
            return client.name ~= "tsserver" and client.name ~= "volar"
        end
    })
end

local languageConfigs = {
    typescript = {
        lsp = {
            tsserver = {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath('config') .. "/node_modules/@vue/typescript-plugin",
                            -- location = "/home/gumacs/dev/vim-config/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            },
            "eslint"
        },
        --     linters = { "eslint" },
        --     formatters = { "prettierd" },
        --     -- dap = { "node2" }
    },
    json = {
        lsp = { "jsonls" },
        formatters = { "prettier" }
    },
    vim = {
        lsp = { "vimls" }
    },
    lua = {
        lsp = {
            lua_ls = {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }
        }
    },
    vue = {
        lsp = { "volar" },
        formatters = { "prettier" },
    },
    svelte = {
        lsp = { "svelte" }
    },
    php = {
        lsp = { "intelephense" },
        linters = { "phpstan" },
        formatter = { "phpcsfixer", "php-cs-fixer", "phpcs" },
        dap = { "php" }
    },
    html = {
        lsp = { "html" }
    },
    css = {
        lsp = { 'cssls', 'tailwindcss' },
        formatters = { "prettier" },
    },
    java = {
        lsp = { "jdtls" }
    },
    kotlin = {
        lsp = { "kotlin_language_server" }
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
local ensureInstalledLsps = {}
local lspConfig = {}
local nullLsconfig = {}
local dapConfig = {}
for lang, config in pairs(languageConfigs) do
    if config.lsp then
        for key, value in pairs(config.lsp) do
            -- print(key, value)
            if type(key) == "number" then
                table.insert(ensureInstalledLsps, value)
            else
                table.insert(ensureInstalledLsps, key)
                lspConfig[key] = value
            end
        end
    end
    if config.formatters then
        for _, formatter in pairs(config.formatters) do
            table.insert(nullLsconfig, formatter)
        end
    end
    if config.linters then
        for _, linter in pairs(config.linters) do
            table.insert(nullLsconfig, linter)
        end
    end
    if config.dap then
        for _, dapAdapter in pairs(config.dap) do
            table.insert(dapConfig, dapAdapter)
        end
    end
    table.insert(treesitterConfig, lang)
end

-- let g:copilot_no_tab_map = v:true
vim.g.copilot_no_tab_map = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
-- vim.opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow "

-- " set autoindent
-- set smartindent
-- filetype plugin indent on " auto indentation based on filetype

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.number = true
-- vim.opt.syntax = "on"
vim.opt.keymodel = "startsel,stopsel"

vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"

vim.opt.list = true
vim.opt.swapfile = false
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     show_current_context = true,
--     -- show_current_context_start = false,
-- }


require 'neovide-config/init'.setup()
require 'theme-config/init'.setup()
require 'treesitter-config/init'.setup(treesitterConfig)
require "general-config/init".setup()
require "autocomplete-config/init".setup()

require "mason".setup() -- This is the main plugin that allow us to install and configure language servers and formatters
require 'lsp-config/init'.setup(ensureInstalledLsps, lspConfig, capabilities)
require 'null-ls-config/init'.setup(nullLsconfig)
require 'dap-config/init'.setup(dapConfig)

print "Sourced init.lua"
