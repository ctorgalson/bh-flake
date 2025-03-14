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

    stylix.url = "github:danth/stylix";
  };

  outputs = { home-manager, nixpkgs, self, sops-nix, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      hostData = import ./hosts/data.nix;
      allowedUnfreePackages = [ "bws" "steam" "zoom-us" ];
    in
    {
      nixosConfigurations = nixpkgs.lib.listToAttrs (map
        (host: {
          name = host.hostname;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit host; inherit inputs; inherit system; };
            modules = [
              sops-nix.nixosModules.sops
              stylix.nixosModules.stylix
              home-manager.nixosModules.default
              {
                home-manager.extraSpecialArgs = {
                  inherit allowedUnfreePackages inputs system;
                };
                home-manager.sharedModules = [
                  # sops-nix.homeManagerModules.sops
                  # stylix.homeManagerModules.stylix
                ];
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
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
