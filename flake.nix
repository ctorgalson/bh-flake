{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, self, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      hostData = import ./hosts/data.nix;
      allowedUnfreePackages = [ "bws" "steam" ];
    in
    {
      nixosConfigurations = nixpkgs.lib.listToAttrs (map
        (host: {
          name = host.hostname;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; inherit system; };
            modules = [
              home-manager.nixosModules.default
              {
                home-manager.extraSpecialArgs = {
                  inherit allowedUnfreePackages inputs system;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
              sopx-nix.nixosModules.sops
              # role configuration.
              ./roles/${host.role}
              # host configuration (including role overrides).
              ./hosts/${host.hostname}
            ];
          };
        })
        hostData);
    };
}
