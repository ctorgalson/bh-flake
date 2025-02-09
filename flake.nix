{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

# Home manager unfree pkgs configuration, and also for general flake
# structure:
# @see https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
  outputs = { home-manager, nixpkgs, self, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    extraSpecialArgs = { inherit system; inherit inputs; };
    specialArgs = { inherit system; inherit inputs; };
    allowed-unfree-packages = [
      "bws"
      "steam"
    ];
    user = "ctorgalson";
  in {
    nixosConfigurations = {
      # @see https://discourse.nixos.org/t/pass-specialargs-to-the-home-manager-module/33068/4
      ser6 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ser6/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
            home-manager.users = {
              "ctorgalson" = import ./modules/home-manager;
            };
          }
        ];
      };
      executive14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/executive14/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
            home-manager.users = {
              "ctorgalson" = import ./modules/home-manager;
            };
          }
        ];
      };
      framework13 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/framework13/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
            home-manager.users = {
              "ctorgalson" = import ./modules/home-manager;
            };
          }
        ];
      };
    };
  };
}
