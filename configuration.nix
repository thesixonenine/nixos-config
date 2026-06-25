{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/desktop.nix
    ./modules/hyprland.nix
    ./modules/noctalia.nix
  ];

  system.stateVersion = "26.05";
}