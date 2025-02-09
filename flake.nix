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
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    extraSpecialArgs = { inherit system; inherit inputs; };
    specialArgs = { inherit system; inherit inputs; };
    allowedUnfreePackages = [ "bws" "steam" ];
    user = "ctorgalson";
    hosts = [ 
      { hostname = "executive14"; type = "desktop"; }
      { hostname = "framework13"; type = "desktop"; }
      { hostname = "ser6"; type = "desktop"; }
    ];
  in {
    nixosConfigurations = lib.listToAttrs (map (host: {
      name = host.hostname;
      value = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${host.hostname}/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowedUnfreePackages inputs user; };
            home-manager.users = {
              "ctorgalson" = import ./modules/home-manager;
            };
          }
        ];
      };
    }) hosts);
  };
}
