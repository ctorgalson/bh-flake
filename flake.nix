{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/esn/knock
    knock = {
      url = "github:esn/knock";
    };
  };

# Home manager unfree pkgs configuration, and also for general flake
# structure:
# @see https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
  outputs = { home-manager, knock, nixpkgs, self, ... }@inputs:
  let
    user = "ctorgalson";
    allowed-unfree-packages = [
      "bws"
      "steam"
    ];
  in {
    nixosConfigurations = {
      ser6 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs knock; };
        modules = [
          ./hosts/ser6/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
          }
        ];
      };
      executive14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs knock; };
        modules = [
          ./hosts/executive14/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
          }
        ];
      };
    };
  };
}
