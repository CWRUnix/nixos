{ config, pkgs, ... }:
{
  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
  systemd.tmpfiles.rules = [
    "d! /etc/hypr 0777 root users"
  ];
}