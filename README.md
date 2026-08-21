# My NixOS Config

从零开始我的 NixOS 配置

> niri does not support software rendering, so niri can't install on Hyper-V. [issue](https://github.com/niri-wm/niri/issues/3527)
> or configure a GPU passthrough render device with Hyper-V.
> [GPU passthrough Reference](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-gpu-assignment-partitioning-passthrough-issues)


## Command

```bash
ls -hl /etc/nixos
```

list generations

```bash
sudo nixos-rebuild list-generations
```

switch generations

```bash
sudo nixos-rebuild switch --flake .#nixos
```

export noctalia.json

```bash
nix run nixpkgs#noctalia-shell ipc call state all > ./modules/features/noctalia.json
```

```bash
nix --extra-experimental-features "nix-command flakes" run nixpkgs#noctalia-shell ipc call state all > ./modules/features/noctalia.json
```

```bash
sudo nixos-rebuild switch --flake github:thesixonenine/nixos-config#nixos
```