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

  options = {
    hostname = pkgs.lib.mkOption {
      type = pkgs.lib.types.str;
      description = "The hostname of the machine.";
    };
    version = pkgs.lib.mkOption {
      type = pkgs.lib.types.str;
      description = "The NixOS version to target.";
    };
  };

  config = {
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
  };
}
