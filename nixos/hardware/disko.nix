{
  config,
  lib,
}:
{
  options.consts.drives = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          device = lib.mkOption {
            type = lib.types.str;
            description = "Path to the drive (e.g., /dev/disk/by-id/...)";
          };
          mountpoint = lib.mkOption {
            type = lib.types.str;
            description = "Mountpoint for the drive";
          };
        };
      }
    );
    description = ''
      Paths to the drives to be used for installation. These should be stable paths, such as
      /dev/disk/by-id/ata-... or /dev/disk/by-uuid/...
    '';
  };

  disko.devices = {
    disk = {
      main = {
        device = config.consts.drives.main.device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              label = "NIXBOOT";
              uuid = "1138a498-29e9-4564-9604-0b0642e83905";
              _index = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "128GB";
              label = "NIXSWAP";
              uuid = "2138a498-29e9-4564-9604-0b0642e83905";
              _index = 3;
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              label = "NIXROOT";
              uuid = "3138a498-29e9-4564-9604-0b0642e83905";
              _index = 3;
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/nix"; # onto the tempfs defined in disks.nix
              };
            };
          };
        };
      };
      large = {
        device = config.consts.drives.storage.device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            storage = {
              size = "100%";
              label = "NIXSTORAGE";
              uuid = "4138a498-29e9-4564-9604-0b0642e83905";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/nix/storage";
              };
            };
          };
        };
      };
    };
  };
}
