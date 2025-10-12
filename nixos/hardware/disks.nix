{ ... }:
{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=64G" # half the amount of swap we have
        "mode=644"
      ];
      neededForBoot = true;
    };
  };
}
