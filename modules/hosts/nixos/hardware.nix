{ self, inputs, ... }: {
# 在复制/etc/nixos/hardware-configuration.nix到这里后,需要在其中追加grub的配置
# boot.loader.grub.efiSupport = true;
# boot.loader.grub.device = "nodev";
# boot.loader.efi.canTouchEfiVariables = true;
  flake.nixosModules.nixosHardware = ;
}