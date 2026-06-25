-- Hyprland Lua Config

-- Monitor
monitor(",preferred,auto,1")

-- Autostart
exec_once("noctalia")

-- Input
input({
    kb_layout = "us"
})

-- General
general({
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2
})

-- Decoration
decoration({
    rounding = 8
})

-- Keybindings
bind("SUPER", "RETURN", "exec", "kitty")
bind("SUPER", "D", "exec", "wofi --show drun")
bind("SUPER", "Q", "killactive")
bind("SUPER", "M", "exit")
bind("SUPER", "V", "exec", "pavucontrol")