{
  description = "Nixos config flake";

  inputs = {
    nix = {
      url = "github:NixOS/nix";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, self, ... }@inputs:

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
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit allowedUnfreePackages inputs hostData system;
                };
              }
              # role configuration.
              ./roles/${host.role}
              # host configuration (including role overrides).
              ./hosts/${host.hostname}
              {
                home-manager.users = {
                  "${host.username}" = import ./modules/home-manager;
                };
              }
            ];
          };
        })
        hostData);
    };
}
