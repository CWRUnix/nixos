{ modulesPath, pkgs, config, ... }:
{
  imports = [
    ./disko.nix
    ./disks.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "sd_mod"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
        "usb_storage"
        "usbhid"
        "rtsx_usb_sdmmc"
        "btrfs"
      ];
      kernelModules = [ "amdgpu" ];
    };

    kernelModules = [
      "kvm-amd"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
    ];

    supportedFilesystems = [
      "btrfs"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libvdpau-va-gl
      vulkan-loader
      vulkan-validation-layers
      mesa.opencl
    ];
  };

  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
