# Disko install config used to intialize the `cwrunix-0` server
# run in a minimal nixos installer:
## 1. nixos-generate-config --root /tmp/config --no-filesystems
## 2. Edit /tmp/config/configuration.nix to 'your liking'
## 3. `mv ./disko-install.nix /tmp/config/etc/nixos/flake.nix`
## 4. sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake '/tmp/config/etc/nixos#cwrunix-0'
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    disko,
    nixpkgs,
  }: let
    hostname = "cwrunix-0";
  in {
    nixosConfigurations."${hostname}" = nixpkgs.legacyPackages.x86_64-linux.nixos [
      ./configuration.nix
      disko.nixosModules.disko
      {
        disko.devices = {
          disk = {
            main = {
              type = "disk";
              device = "/dev/nvme0n1"; # 0n1, 500GB gen 4
              content = {
                type = "gpt";
                partitions = {
                  MBR = {
                    # This is from https://github.com/nix-community/disko/blob/master/docs/disko-install.md
                    type = "EF02"; # for grub MBR
                    size = "1M";
                    priority = 1; # Needs to be first partition
                  };
                  ESP = {
                    # EFI System Partition
                    priority = 1;
                    name = "ESP";
                    size = "512M";
                    type = "EF00";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                      mountOptions = ["umask=0077"];
                    };
                  };
                  root = {
                    size = "100%";
                    content = {
                      type = "btrfs";
                      extraArgs = ["-f"]; # Override existing partition
                      # Subvolumes must set a mountpoint in order to be mounted,
                      # unless their parent is mounted
                      subvolumes = {
                        # Root
                        "/root" = {
                          mountpoint = "/";
                          mountOptions = [
                            "subvol=root"
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        # Holds nix store. I know, this is a small device to hold the nix store. Eventually, we should get a large, networked nix store.
                        "/nix" = {
                          mountpoint = "/nix";
                          mountOptions = [
                            "subvol=nix"
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        # Var/log
                        "/log" = {
                          mountpoint = "/var/log";
                          mountOptions = [
                            "subvol=log"
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        # Subvolume for the swapfile
                        "/swap" = {
                          mountpoint = "/.swapvol";
                          swap = {
                            swapfile.size = "16G";
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
            home = {
              type = "disk";
              device = "/dev/nvme1n1"; # 1n1, 1TB gen 4
              content = {
                type = "gpt";
                partitions = {
                  home = {
                    size = "100%";
                    content = {
                      type = "btrfs";
                      extraArgs = ["-f"]; # Override existing partition
                      subvolumes = {
                        "/home" = {
                          mountpoint = "/home";
                          mountOptions = [
                            "subvol=home"
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      }
    ];
  };
}
