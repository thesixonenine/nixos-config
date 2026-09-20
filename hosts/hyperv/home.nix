{ inputs, config, pkgs, ... }: {
  home.username = "simple";
  home.homeDirectory = "/home/simple";

  home.packages = with pkgs;[
    alacritty
    fastfetch nnn
    zip xz unzip
    ripgrep eza fzf jq fd bat
    age expect openssl
    aria2 socat nmap lsof
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Simple";
      user.email = "thesixonenine@outlook.com";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      nv = "nvim";
      ".." = "cd ..";
      ll = "ls -ahl";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };
  home.file.".config/hypr/hyprland.lua".text = ''
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
    local terminal = "alacritty"
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
  '';
  home.file."wallpapers/default.png".source = ./wallpaper.png;
  home.file.".config/noctalia/config.toml".text = ''
    [theme]
    mode = "dark"
    source = "builtin"
    builtin = "Catppuccin"
    [wallpaper]
    enabled = true
    directory = "/home/simple/wallpapers"
    [wallpaper.default]
    path = "/home/simple/wallpapers/default.png"
  '';
  home.stateVersion = "26.05";
}