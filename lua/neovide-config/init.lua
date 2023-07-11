local M = {}

M.setup = function ()
    if vim.g.neovide then
        vim.o.guifont = 'FiraCode:h10'
        vim.o.linespace = 10

        vim.g.neovide_cursor_animation_length = 0.05
        vim.g.neovide_scroll_animation_length = 0.1

        vim.g.neovide_cursor_vfx_mode = "sonicboom"

        vim.g.neovide_scale_factor = 0.8
        local change_scale_factor = function (delta)
            vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
        end
        vim.keymap.set ('n', '<C-=>', function () change_scale_factor(0.1) end )
        vim.keymap.set ('n', '<C-->', function () change_scale_factor(-0.1) end )

    end
end

return M
