{ pkgs, inputs, ... }:

{
  hardware.bluetooth.enable = true;

  services.upower.enable = true;

  services.power-profiles-daemon.enable = true;

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-substituters = [
      "https://noctalia.cachix.org"
    ];

    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}