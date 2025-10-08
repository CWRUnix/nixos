{ config, pkgs, lib, ... }:
{
  time.timeZone = lib.mkForce "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "all"
    ];
  };
  services.localtimed.enable = true;
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.xkb.layout = "us";
}