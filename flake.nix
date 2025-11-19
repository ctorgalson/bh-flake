{
  description = "Nixos config flake";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

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

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];

    flake = let
      inherit (inputs) nixpkgs home-manager sops-nix stylix;
      system = "x86_64-linux";
      stable-pkgs = import inputs.stable { inherit system; };

      mkHost = hostname: role: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs stable-pkgs system;
            host = { inherit hostname role username; };
          };
          modules = [
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix
            home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = {
                inherit inputs stable-pkgs system;
                host = { inherit hostname role username; };
              };
              home-manager.sharedModules = [
                # sops-nix.homeManagerModules.sops
                # stylix.homeManagerModules.stylix
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            # role configuration.
            ./roles/${role}
            # host configuration (including role overrides).
            ./hosts/${hostname}
          ];
        };
    in {
      nixosConfigurations = {
        framework13 = mkHost "framework13" "desktop" "ctorgalson";
        ser6 = mkHost "ser6" "desktop" "ctorgalson";
        executive14 = mkHost "executive14" "desktop" "ctorgalson";
      };
    };

    perSystem = { pkgs, self', ... }: {
      checks.formatting = pkgs.runCommand "check-formatting"
        {
          nativeBuildInputs = [ pkgs.alejandra pkgs.findutils ];
        } ''
        cd ${inputs.self}
        # Find all .nix files and check formatting
        find . -name '*.nix' -type f -exec alejandra --check {} \;
        touch $out
      '';
    };
  };
}
