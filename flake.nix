{
  description = "Nixos config flake";

  inputs = {
    self.submodules = true;

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

    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    bh-nixvim = {
      url = "github:ctorgalson/bh-nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { bh-nixvim, home-manager, nixpkgs, self, sops-nix, stable, stylix, ... }@inputs:
    let
      stable-pkgs = import stable { inherit system; };
      system = "x86_64-linux";
      hostData = import ./hosts/data.nix;
      allowedUnfreePackages = [ "bws" "steam" "zoom-us" ];
    in
    {
      nixosConfigurations = nixpkgs.lib.listToAttrs (map
        (host: {
          name = host.hostname;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit host inputs stable-pkgs system; };
            modules = [
              sops-nix.nixosModules.sops
              stylix.nixosModules.stylix
              home-manager.nixosModules.default
              {
              	 environment.systemPackages = [ inputs.bh-nixvim.packages."${system}".default ];
              }
              {
                home-manager.extraSpecialArgs = {
                  inherit allowedUnfreePackages host inputs stable-pkgs system;
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
