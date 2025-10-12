{
  consts = {
    drives = {
      main = {
        device = "/dev/disk/by-id/ata-ST20000NM007D-3DJ103_ZVT4D32C";
        mountpoint = "/nix";
        persisted-directories = [
          "/var/log" # -> /nix/persist/var/log
          "/var/lib/secrets"
          "/var/lib/systemd/coredump"
          "/etc/ssh"
        ];
        persisted-files = [
          "/etc/machine-id" # random id of machine (set by systemd)
          "/etc/nix/id_rsa" # private ssh key for nixops
        ];
      };
      storage = {
        device = "/dev/disk/by-id/nvme-CT500P3PSSD8_25154F625340";
        mountpoint = "/nix/storage";
      };
    };
    hostname = "CWRUnix-0";
    version = "25.05";
  };
}
