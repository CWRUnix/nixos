{ pkgs, ... }:
{
  users.users.trm109 = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
    ];
    initialPassword = "changeme";
    shell = pkgs.fish;
  };
}
