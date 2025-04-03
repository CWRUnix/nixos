{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # modules.hardware.nvidia.enable = true; # example module config that we can create.
  system.stateVersion = "24.11"; # never change this unless you reinstall the entire system.

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub = {
  #  # no need to set devices, disko will add all devices that have a
  #  # EF02 partition to the list already
  #  # devices = [ ];
  #  enable = true;
  #  efiSupport = true;
  #  efiInstallAsRemovable = true;
  #};
}
