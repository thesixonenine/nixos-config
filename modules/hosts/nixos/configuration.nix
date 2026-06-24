{ self, inputs, ... }: {

  flake.nixosModules.nixosConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.nixosHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # User configuration
    users.users.simple = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "123";
      extraGroups = [ "wheel" "networkmanager" ];
      description = "Simple";
    };

    environment.systemPackages = with pkgs; [
       vim git curl
    ];
  };

}