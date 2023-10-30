local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

--- Clock Widget
--- ~~~~~~~~~~~~

return function(s)
    local accent_color = beautiful.white
    local clock = wibox.widget({
        widget = wibox.widget.textclock,
        format = "%l  \n----\n%M\n%p",
        align = "center",
        valign = "center",
        font = beautiful.font_name .. "Medium 7",
    })

    clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
    clock:connect_signal("widget::redraw_needed", function()
        clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
    end)

    local clock_widget = wibox.widget({
        clock,
        widget = wibox.container.background,
        bg = beautiful.wibar_bg,
    })

    local icon_widget = wibox.widget({
        widget = wibox.widget.imagebox,
        image = beautiful.pfpf,
        resize = true,
        forced_width = beautiful.xresources.apply_dpi(100),

        forced_height = beautiful.xresources.apply_dpi(40),
        clip_shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
        end,
    })

    local layout = wibox.layout.fixed.vertical()
    layout:add(icon_widget)
    layout:add(clock_widget)

    local widget = wbutton.elevated.state({
        child = layout,
        normal_bg = beautiful.wibar_bg,
        on_release = function()
            awesome.emit_signal("info_panel::toggle", s)
        end,
    })

    return widget
end

