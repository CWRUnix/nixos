{ ... }:

{
  fileSystems = {
    # root
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=64G"
        "mode=755"
      ];
      neededForBoot = true;
    };
  };
}
