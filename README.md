# My NixOS Config

## Install NixOS

1. 在虚拟机软件中使用 NixOS 的图形化 ISO 文件进行安装
2. 在 NixOS 中配置固定 IP 
3. 在宿主机中通过 ssh-copy-id 将宿主机公钥复制到 NixOS
4. 在宿主机中用 ssh 登录 NixOS

## Enable OpenSSH

edit `/etc/nixos/configuration.nix`

```bash
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    PermitRootLogin = "prohibit-password";
    AllowUsers = [ "simple" ];
  };
};
```

rebuild generation

```bash
sudo nixos-rebuild switch
```

## Enable Proxy

edit `/etc/nixos/configuration.nix`

```bash
networking.proxy.default = "http://192.168.137.1:1080/";
networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
```

test

```bash
curl -x http://192.168.137.1:1080 https://www.google.com
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

