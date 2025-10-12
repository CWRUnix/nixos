{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  boot.initrd.availableKernelModules = [
    "sdhci_pci"
    "nvme"
  ];
}
