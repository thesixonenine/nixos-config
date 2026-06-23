{ self, inputs, ... }: {
  flake.nixosModules.nixosHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  };
}