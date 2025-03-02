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


_G.formatCode = function()
    vim.lsp.buf.format({
        timeout_ms = 15000,
        filter = function(client)
            return client.name ~= "ts_ls" and client.name ~= "volar"
        end
    })
end

local function get_plugins()
    local plugins = {}
    for _, plugin in ipairs(vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", '*', 1, 1)) do
        table.insert(plugins, plugin)
    end
    return plugins
end

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

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

-- vim.opt.listchars:append "eol:↴"

-- vim.g.wildfire_objects = { "i'", "a'", 'i"', 'a"', "i)", "a)", "i]", "a]", "i}", "a}", "it", "at" }

require 'neovide-config/init'.setup()
require 'theme-config/init'.setup()
require 'treesitter-config/init'.setup(treesitterConfig)
require "general-config/init".setup()
require "autocomplete-config/init".setup()

require "mason".setup() -- This is the main plugin that allow us to install and configure language servers and formatters
require 'lsp-config/init'.setup()
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
