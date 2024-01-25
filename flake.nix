# flake.nix
{
  description = "Standard Configured Flake for CWRUnix Servers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
	inherit system;
	config = { allowUnfree = true; };
      };
    in
    {
      nixosConfigurations = {
	default = nixpkgs.lib.nixosSystem {
	  specialArgs = { inherit inputs system; };
	  modules = [
	    ./hardware-configuration.nix
	    ./users/user.nix
      ./configuration.nix
	    inputs.home-manager.nixosModules.default
	  ];
	};
	gaming = nixpkgs.lib.nixosSystem {};
      };
    };
}
