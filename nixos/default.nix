{ pkgs, version, ... }:
{
  imports = [
    ./boot.nix
    ./cloudflare.nix
    ./localization.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./proxmox.nix
    ./sops.nix

    ./admins
    ./hardware
    ./userspace
  ];

  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
  };

  environment.systemPackages = with pkgs; [
    nano
    neovim
    man-pages
    man-pages-posix
  ];

  system.stateVersion = version;
}
