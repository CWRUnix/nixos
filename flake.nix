{
  description = "The Official NixOS flake for the Linux Club of Case Western Reserve University";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      # Declaratively manages our disk partitions
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      disko,
      ...
    }:
    {
      nixosConfigurations =
        let
          modules = [
            ./hosts # Holds the 'host' configurations; i.e. the configurations for each machine (HARDWARE BASED)
            ./modules # Holds the 'module' configurations; i.e. the configurations for each service.
            ./users # Holds the 'user' configurations; i.e. the configurations for each user.
            disko.nixosModules.disko
            {
              nixpkgs.overlays = [
                (_final: prev: {
                  unstable = nixpkgs-unstable.legacyPackages.${prev.system};
                })
              ];
            }
          ];
        in
        {
          cwrunix-0 = nixpkgs.lib.nixosSystem {
            # Our flagship server, cwrunix-0.
            specialArgs = {
              hostname = "cwrunix-0";
            };
            system = "x86_64-linux";
            inherit modules;
          };
        };
    };
}
