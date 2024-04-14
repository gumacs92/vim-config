
        vim.o.guifont = 'MonaspiceNe NFM Medium:h10'
        vim.o.linespace = 10

        vim.g.neovide_remember_window_size = true

        vim.g.neovide_no_idle = true
        vim.g.neovide_cursor_animation_length = 0.02
        vim.g.neovide_scroll_animation_length = 0.05

        vim.g.neovide_cursor_vfx_mode = "sonicboom"

        vim.g.neovide_scale_factor = 1
        local change_scale_factor = function(delta)
            vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
        end
        vim.keymap.set('n', '<C-=>', function() change_scale_factor(0.1) end)
        vim.keymap.set('n', '<C-->', function() change_scale_factor(-0.1) end)
