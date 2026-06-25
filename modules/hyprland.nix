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

    cp ${../config/hyprland.conf} \
      /home/simple/.config/hypr/hyprland.conf

    chown -R simple:users /home/simple/.config
  '';
}