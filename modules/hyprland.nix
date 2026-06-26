{ pkgs, ... }:

{
  # Hyprland Cachix cache for pre-built binaries
  nix.settings = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    # extra-trusted-substituters = [ "https://hyprland.cachix.org" ];
    # extra-trusted-users = [ "root" "@wheel" ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.etc."hypr/hyprland.lua".source = ./hyprland.lua;

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
}