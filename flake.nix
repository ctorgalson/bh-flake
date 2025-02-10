{
  description = "Nixos config flake";

  inputs = {
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
              # role configuration.
              ./roles/${host.role}
              # home-manager configuration (temp)
              home-manager.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit allowedUnfreePackages inputs hostData system;
                };
              }
              {
                home-manager.users = {
                  "${host.username}" = import ./modules/home-manager;
                };
              }
              # host configuration (including role overrides).
              ./hosts/${host.hostname}
            ];
          };
        })
        hostData);
    };
}
