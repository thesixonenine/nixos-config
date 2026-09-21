# My NixOS Config

从零开始我的 NixOS 配置

> niri does not support software rendering, so niri can't install on Hyper-V. [issue](https://github.com/niri-wm/niri/issues/3527)
> or configure a GPU passthrough render device with Hyper-V.
> [GPU passthrough Reference](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-gpu-assignment-partitioning-passthrough-issues)


## Hyper-V

在目标机器上从 ISO 启动到 LiveCD 环境

切换到 root 用户

```bash
sudo -i
```

查询 IP 与重置密码, 以便在局域网的其他机器上继续执行安装命令

```bash
ip a
passwd
```

在局域网的其他机器上继续执行

将配置文件复制到目标机器上

```bash
scp -r ./hosts root@192.168.137.41:/root/
scp ./flake.nix root@192.168.137.41:/root/
scp ./flake.lock root@192.168.137.41:/root/
```

登录目标机器

```bash
ssh root@192.168.137.41
```

分区

```bash
NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /root/hosts/hyperv/disko.nix
```


生成配置

```bash
nixos-generate-config --no-filesystems --root /mnt
```

移动自定义配置

```bash
mv -f /root/hosts /mnt/etc/nixos/ && \
mv -f /root/flake.nix /mnt/etc/nixos/ && \
mv -f /root/flake.lock /mnt/etc/nixos/ && \
```

执行安装

```bash
yes | NIX_CONFIG="access-tokens = github.com=github_pat_xxx" \
HTTP_PROXY="http://192.168.137.1:1080" HTTPS_PROXY="http://192.168.137.1:1080" \
nixos-install --flake /mnt/etc/nixos#hyperv
```

关机

```bash
shutdown now
```

重启

查看现有连接

```bash
nmcli -f NAME,UUID,FILENAME connection show
```

停止已有连接

```bash
nmcli connection down "Wired connection 1"
```

启动配置连接

```bash
nmcli connection up eth0
```

删除已停止连接

```bash
nmcli connection delete "Wired connection 1"
```

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