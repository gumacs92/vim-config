local utils = require('utils')
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

local M = {}

M.setup = function()
    vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("")', { silent = true, expr = true, noremap = true })

    -- nvim-cmp setup
    cmp.setup {
        -- luasnip setupauto
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            expandable_indicator = true,
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50,
                    -- maxwidth = {
                    --     -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    --     -- can also be a function to dynamically calculate max width such as
                    --     -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                    --     menu = 50,            -- leading text (labelDetails)
                    --     abbr = 50,            -- actual suggestion item
                    -- },
                    ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        -- local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        -- kind.kind = " " .. (strings[1] or "") .. " "
                        -- kind.menu = "    (" .. (strings[2] or "") .. ")"
                        -- return kind
                        return vim_item
                    end
                })(entry, vim_item)
                -- local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end
        },
        -- formatting = {
        --     format = function(entry, vim_item)
        --         local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        --         local strings = vim.split(kind.kind, "%s", { trimempty = true })
        --         kind.kind = " " .. (strings[1] or "") .. " "
        --         kind.menu = "    (" .. (strings[2] or "") .. ")"
        --
        --         return kind
        --     end,
        -- },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif utils.has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            -- { name = 'vim-dadbod-completion' },
            { name = 'buffer' },
            -- { name = "cmp-dbee",
            --     entry_filter = function(entry, ctx)
            --         local ok, result = pcall(function() return entry:get_completion() end)
            --         return ok and result ~= nil
            --     end,
            -- },
        }),
    }
end

return M
