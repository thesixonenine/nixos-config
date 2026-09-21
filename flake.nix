{
  description = "My NixOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };
  # find cachix in `nixos-rebuild switch`
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
    extra-trusted-substituters = [ "https://hyprland.cachix.org" "https://noctalia.cachix.org" ];
  };
  outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: {
    # Define a system called "hyperv"
    nixosConfigurations.hyperv = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/hyperv/configuration.nix
        disko.nixosModules.disko
        ./hosts/hyperv/disko.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.simple = ./hosts/hyperv/home.nix;
        }
      ];
    };

    # Define a system called "itx"
    nixosConfigurations.itx = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/itx/configuration.nix
        disko.nixosModules.disko
        ./hosts/itx/disko.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.simple = ./hosts/itx/home.nix;
        }
      ];
    };
  };
}