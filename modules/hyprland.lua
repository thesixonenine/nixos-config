-- Monitor
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1",
})

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
end)

-- Input
hl.config({
  input = {
    kb_layout = "us"
  },
})

-- General
hl.config({
  general = {
    gaps_in  = 5,
    gaps_out = 20,
    border_size = 2,
  },
  decoration = {
    rounding = 8,
  },
})

-- Keybindings
local terminal = "kitty"
local mainMod = "SUPER"
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
