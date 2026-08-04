# My NixOS Config

## Command

`list generations`

```bash
sudo nixos-rebuild list-generations
```

`switch generations`

```bash
sudo NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nixos-rebuild switch --flake /etc/nixos#nixos
```

from github

```bash
sudo NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nixos-rebuild switch --flake github:thesixonenine/nixos-config#nixos
```

## Install With disko At Hyper-V

1. into liveCD from nixos-minimal-x86_64-linux
2. use `passwd` reset password
3. use `ip a` get IP
4. use `ssh nixos@192.168.137.124` connect to VM at host machine
5. upload repo to `~/config` and `cd ~/config`

then start install.

setting proxy

```bash
sudo mkdir -p /run/systemd/system/nix-daemon.service.d/ && \
printf '[Service]\nEnvironment="https_proxy=http://192.168.137.1:1080"\n' | \
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf && \
sudo systemctl daemon-reload && \
sudo systemctl restart nix-daemon
```

test

```bash
curl -x http://192.168.137.1:1080 https://www.google.com/blank.html
```

`Fetch My NixOS Config`

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

first, install with disko

`mkdir ~/config && cd ~/config`

```bash
sudo NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko ./disko.nix
```

update flake

```bash
sudo NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nix --extra-experimental-features "nix-command flakes" flake update
```

second, write generate-config

```bash
sudo nixos-generate-config --root /mnt
```

finally, install NixOS

```bash
sudo nixos-install --flake .#nixos
```
