{
  description = "CWRUnix club server";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };

  outputs =
    {
      self,
      ...
    }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        devShells = {
          default = pkgs.mkShell {
            SOPS_AGE_KEY_FILE = "key.txt";
            packages = with pkgs; [
              nil
              nixd
              sops
              age
              gnupg
            ];
          };
        };
        nixosConfigurations = rec {
          default = server;
          server = inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs system; };
            modules = [
              inputs.disko.nixosModules.disko
              inputs.sops-nix.nixosModules.sops
              inputs.impermanence.nixosModules.impermanence
              ./nixos
              inputs.proxmox-nixos.nixosModules.proxmox-ve
            ];
          };
        };
        formatter =
          let
            treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
              projectRootFile = "flake.nix";
              programs = {
                nixfmt.enable = true;
                prettier.enable = true;
              };
            };
          in
          treefmtconfig.config.build.wrapper;
      }
    );
}
