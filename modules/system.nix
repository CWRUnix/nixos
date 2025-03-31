{pkgs, ...}: {
  # Core stuff here.
  networking = {
    networkmanager = {
      enable = true;
    };
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

  nixpkgs.config.allowUnfree = true;
}
