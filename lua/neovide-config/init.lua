local M = {}


M.setup = function()
    -- if vim.g.neovide then
    -- fonts must be installed inside windows
    vim.o.guifont = 'FiraCode NF Retina:h16:w0'
    vim.o.linespace = 3

    vim.g.neovide_padding_top = 20
    vim.g.neovide_padding_bottom = 20
    vim.g.neovide_padding_right = 20
    vim.g.neovide_padding_left = 20

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_light_angle_degrees = 30
    vim.g.neovide_light_radius = 10

    vim.g.neovide_remember_window_size = true
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_no_idle = true
    vim.g.neovide_scroll_animation_length = 0.05
    vim.g.neovide_cursor_animation_length = 0.02

    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
    vim.g.neovide_cursor_animate_in_insert_mode = true

    vim.g.neovide_scale_factor = 0.7
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
    end
    vim.keymap.set('n', '<C-=>', function() change_scale_factor(0.1) end)
    vim.keymap.set('n', '<C-->', function() change_scale_factor(-0.1) end)
    -- end
end


return M
