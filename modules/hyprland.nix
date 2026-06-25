{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  environment.systemPackages = with pkgs; [
    kitty

    hyprpaper
    hyprlock
    hypridle

    wl-clipboard
    grim
    slurp

    brightnessctl
    playerctl

    pavucontrol

    wofi
  ];

  system.activationScripts.hyprlandConfig.text = ''
  mkdir -p /home/simple/.config/hypr

  cat > /home/simple/.config/hypr/hyprland.conf <<'EOF'
  monitor=,preferred,auto,1

  exec-once = noctalia

  input {
      kb_layout = us
  }

  general {
      gaps_in = 5
      gaps_out = 10
      border_size = 2
  }

  decoration {
      rounding = 8
  }

  bind = SUPER, RETURN, exec, kitty
  bind = SUPER, D, exec, wofi --show drun

  bind = SUPER, Q, killactive
  bind = SUPER, M, exit

  bind = SUPER, V, exec, pavucontrol
  EOF

  chown -R simple:users /home/simple/.config
  '';

#  system.activationScripts.hyprlandConfig.text = ''
#    mkdir -p /home/simple/.config/hypr
#    cp ${../config/hyprland.conf} /home/simple/.config/hypr/hyprland.conf
#    chown -R simple:users /home/simple/.config
#  '';
}