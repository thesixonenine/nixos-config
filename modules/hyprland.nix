{ pkgs, lib, ... }:

{
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    # 终端 启动器 剪贴板        壁纸
    kitty  wofi wl-clipboard hyprpaper

    # 自动锁屏
    hyprlock
    hypridle

    # 截图
    grim
    slurp

    # 音频控制
    pavucontrol
  ];
}