{ inputs, config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix inputs.noctalia.nixosModules.default ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;
  system.stateVersion = "26.05";
  networking.hostName = "nixos";
  networking.proxy.default = "http://192.168.137.1:1080";
  networking.networkmanager.ensureProfiles.profiles = {
    "eth0" = {
      connection = {
        id = "eth0";
        uuid = "9f6f3a52-1b88-4b0d-a2d0-8b7e3b4c9a01";
        type = "ethernet";
        interface-name = "eth0";
        autoconnect = true;
      };
      ipv4 = {
        method = "manual";
        address1 = "192.168.137.10/24,192.168.137.1";
        dns = "223.5.5.5;223.6.6.6;";
      };
      ipv6.method = "disabled";
      ethernet = {};
    };
  };
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };
  users.users."simple" = {
    isNormalUser = true;
    description = "Simple";
    initialPassword = "1";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfY4AqFEB76gUXJKVifON936yf/MdsOKTsmioQ3HDKi" ];
  };
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      AllowUsers = [ "simple" ];
    };
  };
  environment.systemPackages = with pkgs; [ vim git curl ];
  environment.variables.EDITOR = "vim";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.access-tokens = [ "github.com=github_pat_xxx" ];
  # Hyprland Noctalia
  nix.settings = {
    extra-substituters = ["https://hyprland.cachix.org" "https://noctalia.cachix.org"];
    extra-trusted-substituters = ["https://hyprland.cachix.org" "https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    extra-trusted-users = ["root" "@wheel" "simple"];
  };
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  programs.noctalia.enable = true;
}