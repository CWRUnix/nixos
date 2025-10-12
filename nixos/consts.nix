{
  consts = {
    drives = {
      main = {
        device = "/dev/disk/by-id/ata-ST20000NM007D-3DJ103_ZVT4D32C";
        mountpoint = "/mnt/main";
      };
      storage = {
        device = "/dev/disk/by-id/nvme-CT500P3PSSD8_25154F625340";
        mountpoint = "/mnt/storage";
      };
    };
  };
  hostname = "CWRUnix-0";
  version = "25.05";
}
