# /users/user.nix

{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
  };
  programs.fish.enable = true;
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" "docker" ];
    shell = pkgs.fish;
  };
}
