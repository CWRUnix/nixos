{ pkgs, ... }:
{
  imports = [
    ./greetd.nix
    ./hyprland.nix
  ];
  fonts = {
    packages =
      with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        font-awesome
      ]
      ++ lib.lists.filter lib.isDerivation (builtins.attrValues nerd-fonts);
    enableDefaultPackages = true;
  };
  programs.dconf.enable = true;
}
