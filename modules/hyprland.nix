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

  environment.etc."hypr/hyprland.lua".source = ./hyprland.lua;
}