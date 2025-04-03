{
  hostname,
  lib,
  pkgs,
  ...
}:
{
  # Core stuff here.
  networking = {
    networkmanager = {
      enable = true;
    };
    hostName = "${hostname}";
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services = {
    openssh = {
      enable = true;
    };
  };

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_6_14;

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
