{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

# Home manager unfree pkgs configuration, and also for general flake
# structure:
# @see https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
  outputs = { home-manager, nixpkgs, self, ... }@inputs:
  let
    allowed-unfree-packages = [
      "bws"
      "steam"
    ];
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    system = "x86_64-linux";
    user = "ctorgalson";
    extraSpecialArgs = { inherit system; inherit inputs; };  # <- passing inputs to the attribute set for home-manager
    specialArgs = { inherit system; inherit inputs; };       # <- passing inputs to the attribute set for NixOS (opti
  in {
    nixosConfigurations = {
      ser6 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ser6/configuration.nix
          {
            nixpkgs = {
              overlays = [
                (final: prev: {
                    nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
                })
              ];
            };
          }
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit allowed-unfree-packages inputs user; };
          }
        ];
      };
      executive14 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/executive14/configuration.nix
          {
            nixpkgs = {
              overlays = [
                (final: prev: {
                    nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
                })
              ];
            };
          }
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
