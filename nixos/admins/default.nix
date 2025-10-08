{ pkgs, ... }:
{
  imports = [
    ./tev.nix
  ];
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}