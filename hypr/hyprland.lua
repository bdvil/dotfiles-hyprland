-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = "auto",
})

hl.monitor({
    output = "HDMI-A-2",
    mode = "preferred",
    position = "0x1080",
    scale = 1.5,
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --insensitive --show drun --allow-images -D key_expand=Tab"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

hl.on("hyprland.start", function()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"')
    hl.exec_cmd([[gsettings set org.gnome.mutter experimental-features \"['scale-monitor-framebuffer']"]])

    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hypridle")


    -- Stores only text data
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    -- Stores only image data
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct # change to qt6ct if you have that")
hl.env("QT_SCALE_FACTOR_ROUNDING_POLICY", "RoundPreferFloor  # for calibre fonts")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("GDK_BACKEND,wayland,x11", "*")
hl.env("GDK_SCALE", "2")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 8,

        border_size      = 2,

        col              = {
            active_border   = { colors = { "rgba(c07dffff)", "rgba(f542a1ff)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },

    decoration = {
        rounding         = 2,
        rounding_power   = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur             = {
            enabled  = false,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    xwayland = {
        force_zero_scaling = true
    },
})

-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "fr",
        kb_variant   = "azerty",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
hl.device({
    name       = "zsa-technology-labs-moonlander-mark-i",
    kb_layout  = "fr",
    kb_variant = "ergol",
})

hl.device({
    name       = "zsa-technology-labs-voyager",
    kb_layout  = "fr",
    kb_variant = "ergol",
})

hl.device({
    name    = "elan2557:00-04f3:2557-stylus",
    enabled = false,
})

hl.device({
    name    = "elan2557:00-04f3:2557",
    enabled = false,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local mehMod = "ALT + SHIFT + CTRL"
local hyperMod = "ALT + SHIFT + CTRL + SUPER"

-- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("systemctl hibernate"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("pidof hyprlock || hyperlock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/select_monitor.sh"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd([[grim -g "$(slurp)"]]))
hl.bind("ALT + h",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = math.floor(w
                .size.x * -10 / 100),
            y = 0,
            relative = true
        }))
    end)
hl.bind("ALT + l",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = math.floor(w
                .size.x * 10 / 100),
            y = 0,
            relative = true
        }))
    end)
hl.bind("ALT + k",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = 0,
            y = math
                .floor(w.size.y * -10 / 100),
            relative = true
        }))
    end)
hl.bind("ALT + j",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = 0,
            y = math
                .floor(w.size.y * 10 / 100),
            relative = true
        }))
    end)

hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ into_or_create_group = "r" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ into_or_create_group = "u" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ into_or_create_group = "d" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + code:10", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + code:11", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + code:12", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + code:13", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + code:14", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + code:15", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + code:16", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + code:17", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + code:18", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + code:19", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + code:10", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + code:11", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + code:12", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + code:13", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + code:14", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + code:15", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + code:16", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + code:17", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + code:18", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + code:19", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+r" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy]]))

hl.bind("ALT + Left",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = math.floor(w
                .size.x * -10 / 100),
            y = 0,
            relative = true
        }))
    end)
hl.bind("ALT + Right",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = math.floor(w
                .size.x * 10 / 100),
            y = 0,
            relative = true
        }))
    end)
hl.bind("ALT + Up",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = 0,
            y = math
                .floor(w.size.y * -10 / 100),
            relative = true
        }))
    end)
hl.bind("ALT + Down",
    function()
        local w = hl.get_active_window(); if not w then return end; hl.dispatch(hl.dsp.window.resize({
            x = 0,
            y = math
                .floor(w.size.y * 10 / 100),
            relative = true
        }))
    end)

hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))

hl.bind(mehMod .. " + l", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind(mehMod .. " + r", hl.dsp.window.move({ into_or_create_group = "r" }))
hl.bind(mehMod .. " + t", hl.dsp.window.move({ into_or_create_group = "u" }))
hl.bind(mehMod .. " + i", hl.dsp.window.move({ into_or_create_group = "d" }))

hl.bind(mehMod .. " + q", hl.dsp.focus({ workspace = 1 }))
hl.bind(mehMod .. " + c", hl.dsp.focus({ workspace = 2 }))
hl.bind(mehMod .. " + o", hl.dsp.focus({ workspace = 4 }))
hl.bind(mehMod .. " + p", hl.dsp.focus({ workspace = 5 }))
hl.bind(mehMod .. " + w", hl.dsp.focus({ workspace = 6 }))
hl.bind(mehMod .. " + j", hl.dsp.focus({ workspace = 7 }))
hl.bind(mehMod .. " + m", hl.dsp.focus({ workspace = 8 }))

hl.bind(mehMod .. " + SHIFT + q", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mehMod .. " + SHIFT + c", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mehMod .. " + SHIFT + o", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mehMod .. " + SHIFT + p", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mehMod .. " + SHIFT + w", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mehMod .. " + SHIFT + j", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mehMod .. " + SHIFT + m", hl.dsp.window.move({ workspace = 8 }))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    match = {
        class = "^(kitty)$",
    },
    workspace = "1",
})

hl.window_rule({
    match = {
        class = "^(zen)$",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(zen)$",
        title = "(Picture-in-Picture)",
    },
    float = true,
    pin = true,
})

hl.window_rule({
    match = {
        class = "^(firefox)$",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(firefox)$",
        title = "(Picture-in-Picture)",
    },
    float = true,
    pin = true,
})

hl.window_rule({
    match = {
        class = "^(Chromium)$",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(.*)(dolphin)$",
    },
    workspace = "3",
})

hl.window_rule({
    match = {
        class = "^(.*)(org.gnome.Nautilus)$",
    },
    workspace = "3",
})

hl.window_rule({
    match = {
        class = "^(vlc)$",
    },
    workspace = "4",
})

hl.window_rule({
    match = {
        title = "^(Grayjay)$",
    },
    float = false,
    workspace = "4",
})

hl.window_rule({
    match = {
        class = "^(org.mozilla.Thunderbird)$",
    },
    workspace = "5",
})

hl.window_rule({
    match = {
        class = "^(.*)(Fractal)$",
    },
    workspace = "6",
})

hl.window_rule({
    match = {
        class = "^(Element)$",
    },
    workspace = "6",
})

hl.window_rule({
    match = {
        class = "^(SchildiChatAlpha)$",
    },
    workspace = "6",
})

hl.window_rule({
    match = {
        class = "^(cinny)$",
    },
    workspace = "6",
})

hl.window_rule({
    match = {
        class = "^(org.keepassxc.KeePassXC)$",
    },
    workspace = "7",
})

hl.window_rule({
    match = {
        class = "^(org.keepassxc.KeePassXC)$",
        title = "(KeePassXC - Passkey credentials)",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(org.keepassxc.KeePassXC)$",
        title = "(KeePassXC - Browser Access Request)",
    },
    workspace = "2",
})

hl.window_rule({
    match = {
        class = "^(blueman-manager)$",
    },
    workspace = "8",
})

hl.window_rule({
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
    },
    workspace = "8",
})
