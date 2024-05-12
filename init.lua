---------------------------------------------------------------------------
-- lazy.nvim base config
---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')
---------------------------------------------------------------------------


require 'mappings'.setup()
require 'autocommands'.setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local wk = require("which-key")
-- wk.setup {}
--
--

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
                            languages = { "javascript", "typescript", "vue" },
                            location = vim.fn.stdpath('config') .. "/node_modules/@vue/typescript-plugin",
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                    "typescriptreact",
                    "javascriptreact",
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
                                vim.env.VIMRUNTIME,
                                vim.fn.stdpath('config') .. "/plugged",
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

-- -- let g:copilot_no_tab_map = v:true
vim.g.copilot_node_command = "~/.nvm/versions/node/v18.12.1/bin/node"
vim.g.copilot_no_tab_map = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("wl-copy") == 0 then
        print("wl-copy not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = "wl-clipboard (wsl)",
            copy = {
                ["+"] = 'wl-copy --foreground --type text/plain',
                ["*"] = 'wl-copy --foreground --primary --type text/plaing'
            },
            paste = {
                ["+"] = (function()
                    return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { '' }, 1) -- '1' keeps empty lines
                end),
                ["*"] = (function()
                    return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { '' }, 1)
                end)
            },
            cache_enabled = true
        }
    end
end

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

vim.g.wildfire_objects = { "i'", "a'", 'i"', 'a"', "i)", "a)", "i]", "a]", "i}", "a}", "it", "at" }

require 'neovide-config/init'.setup()
require 'theme-config/init'.setup()
require 'treesitter-config/init'.setup(treesitterConfig)
require "general-config/init".setup()
require "autocomplete-config/init".setup()

require "mason".setup() -- This is the main plugin that allow us to install and configure language servers and formatters
require 'lsp-config/init'.setup(ensureInstalledLsps, lspConfig, capabilities)
require 'null-ls-config/init'.setup(nullLsconfig)
require 'git-config/init'.setup()
require 'dap-config/init'.setup(dapConfig)



local oil = require("oil")
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_keymap('n', '<CR>', '', { noremap = true, silent = true })
        vim.keymap.set("n", "<CR>", function()
            if vim.bo.filetype == "oil" then
                oil.select()
            else
                vim.cmd(":normal <Plug>(wildfire-fuel)")
            end
        end, { desc = "Map enter for oil and plug", noremap = true })
    end
})

print "Sourced init.lua"
