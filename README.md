# My NixOS Config

## Command

```bash
sudo nixos-rebuild switch --flake .#nixos
```

```bash
nix run nixpkgs#noctalia-shell ipc call state all > ./modules/features/noctalia.json
```

```bash
sudo nixos-rebuild switch --flake github:thesixonenine/nixos-config#nixos
```

