{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" ];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  services.fstrim.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.proxy.default = "http://192.168.137.1:1080/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  # for hyper-v
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
        address1 = "192.168.137.20/24,192.168.137.1";
        dns = "223.5.5.5;223.6.6.6;";
      };
      ipv6 = {
        method = "disabled";
      };
      ethernet = {
        mac-address-blacklist = "";
      };
    };
  };
  # networking.useDHCP = false;

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
    shell = pkgs.zsh;
    description = "Simple";
    initialPassword = "1";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfY4AqFEB76gUXJKVifON936yf/MdsOKTsmioQ3HDKi" ];
  };
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
      AllowUsers = [ "simple" ];
    };
  };
  environment.systemPackages = with pkgs; [ vim git curl ];
  environment.variables.EDITOR = "vim";
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
}