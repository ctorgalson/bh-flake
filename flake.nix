{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Home manager unfree pkgs configuration:
  # @see https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      ser6 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ser6/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      executive-14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/executive-14/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
