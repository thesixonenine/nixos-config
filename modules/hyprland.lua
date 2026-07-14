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
