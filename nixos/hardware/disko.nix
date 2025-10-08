{
  disko.devices = {
    disk = {
      main = {
        # When using disko-install, we will overwrite this value from the commandline
        device = "/dev/disk/by-id/some-disk-id";
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
                mountpoint = "/nix";
              };
            };
          };
        };
      };
      large = {
        device = "/dev/disk/by-id/some-disk-id";
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
