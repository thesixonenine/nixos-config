{
  description = "A simple NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # hostname: nixos
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        # import configuration.nix
        ./configuration.nix
      ];
    };
  };
}
