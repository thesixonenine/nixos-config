# My NixOS Config

## Install NixOS

直接在虚拟机软件中使用 NixOS 的图形化 ISO 文件进行安装默认 GNOME 桌面环境

安装好后为了好从宿主机进行操作, 所以要通过 SSH 连接到 NiOS 中

1. 在 NixOS 中图形化配置固定 IP (桌面右上角网络标识)
2. 在 NixOS 中用终端配置启动 OpenSSH (通过 Console 应用, 参考下面的 `Enable OpenSSH`)
3. 构建新世代(参考下面的 `Rebuild Generation`)并重启 NixOS 虚拟机
4. 在宿主机中通过 SSH 连接 NixOS 虚拟机

然后就可以按以下步骤在宿主机中继续配置 NixOS 了

## OpenSSH

### Enable OpenSSH

edit `/etc/nixos/configuration.nix`

```bash
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    PermitRootLogin = "no";
    AllowUsers = [ "simple" ];
  };
};
```

or only enable openssh

```bash
services.openssh.enable = true;
```

### PublicKey

use `ssh-copy-id` or edit `/etc/nixos/configuration.nix`

```bash
users.users."simple".openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfY4AqFEB76gUXJKVifON936yf/MdsOKTsmioQ3HDKi"
];
```

## Network

### Enable Proxy

edit `/etc/nixos/configuration.nix`

```bash
networking.proxy.default = "http://192.168.137.1:1080/";
networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
```

test

```bash
curl -x http://192.168.137.1:1080 https://www.google.com
```

### Static IP

`我配置没有生效,反而把原有的网卡挤掉了,此处存疑`

edit `/etc/nixos/configuration.nix`

```bash
networking.interfaces.eth0.ipv4.addresses = [
  {
    address = "192.168.137.13";
    prefixLength = 24;
  }
];
networking.defaultGateway = "192.168.137.1";
networking.nameservers = [
  "223.5.5.5"
  "223.6.6.6"
];
networking.useDHCP = false;
```

## Software

edit `/etc/nixos/configuration.nix`

```bash
environment.systemPackages = with pkgs; [
  vim git curl
];
```

## Rebuild Generation

```bash
sudo nixos-rebuild switch --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
```
## Hyprland and Noctalia

```bash
cd /etc/nixos
```

update Nixpkgs Hyprland Noctalia to flake.lock

```bash
sudo NIX_CONFIG="access-tokens = github.com=ghp_xxx" nix --extra-experimental-features "nix-command flakes" flake update
```

update config

```bash
sudo nixos-rebuild switch --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" --flake .#nixos
```

test config

```bash
sudo nixos-rebuild test --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" --flake .#nixos
```

prevent Hyprland from generating an auto config

```bash
mkdir -p ~/.config/hypr && ln -sf /etc/hypr/hyprland.lua ~/.config/hypr/hyprland.lua
```

cat ~/.bash_profile

```bash
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec start-hyprland --config /etc/hypr/hyprland.lua
fi
```

proxy

```bash
sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=http://192.168.137.1:1080"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
```

## Fetch My NixOS Config

```bash
cd && git clone git@github.com:thesixonenine/nixos-config.git
```

use `cUrl`

```bash
cd && curl -fsSL -o main.tar.gz https://github.com/thesixonenine/nixos-config/tarball/main
```

unzip

```bash
tar -zxf ./main.tar.gz
```

## Command

### list generations

```bash
nixos-rebuild list-generations
```

```bash
sudo nixos-rebuild switch --flake .#nixos
```

```bash
nix run nixpkgs#noctalia-shell ipc call state all > ./modules/features/noctalia.json
```

```bash
nix --extra-experimental-features "nix-command flakes" run nixpkgs#noctalia-shell ipc call state all > ./modules/features/noctalia.json
```

```bash
sudo nixos-rebuild switch --flake github:thesixonenine/nixos-config#nixos
```

