{
  description = "Nixos config flake";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Keep unstable available for cherry-picking newer packages if needed
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    bh-nixvim = {
      url = "github:ctorgalson/bh-nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-pi-zero-2 = {
      url = "github:ctorgalson/nixos-pi-zero-2/2025/12/feature/update-for-nixos-25-11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];

    flake = let
      inherit (inputs) nixpkgs home-manager sops-nix stylix;
      system = "x86_64-linux";
      unstable-pkgs = import inputs.unstable { inherit system; };

      mkColmenaHost = hostname: role: username: hostSystem: {
        deployment = {
          targetHost = hostname;
          targetUser = "bh";
          allowLocalDeployment = true;
        };

        _module.args = {
          # Use x86_64 system for building if target is aarch64
          system = if hostSystem == "aarch64-linux" then "x86_64-linux" else hostSystem;
          host = { inherit hostname role username; };
        };

        imports = [
          sops-nix.nixosModules.sops
          stylix.nixosModules.stylix
          home-manager.nixosModules.default
          {
            home-manager.extraSpecialArgs = {
              inherit inputs unstable-pkgs;
              system = hostSystem;
              host = { inherit hostname role username; };
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          ./roles/${role}
          ./hosts/${hostname}
        ];

        nixpkgs.hostPlatform = hostSystem;
      };

      mkHost = hostname: role: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs unstable-pkgs system;
            host = { inherit hostname role username; };
          };
          modules = [
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix
            home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = {
                inherit inputs unstable-pkgs system;
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

        # Raspberry Pi Zero 2 W - network appliance
        # Uses simpler approach based on plmercereau/nixos-pi-zero-2
        pi0 = let
          crossPkgs = import nixpkgs {
            localSystem = system;
            crossSystem = "aarch64-linux";
          };
        in nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs unstable-pkgs system;
          };
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            sops-nix.nixosModules.sops
            ./hosts/pi0
            {
              nixpkgs.pkgs = crossPkgs; # Configure cross compilation

              # SD Image specific configuration
              sdImage = {
                compressImage = false;
                imageName = "pi0.img";
                extraFirmwareConfig = {
                  start_x = 0;
                  gpu_mem = 16;
                };
              };
            }
          ];
        };
      };

      # Colmena deployment configuration
      colmena = {
        meta = {
          nixpkgs = import nixpkgs { inherit system; };
          specialArgs = { inherit inputs unstable-pkgs; };
        };

        # Desktop hosts (x86_64-linux)
        framework13 = mkColmenaHost "framework13" "desktop" "ctorgalson" system;
        ser6 = mkColmenaHost "ser6" "desktop" "ctorgalson" system;
        executive14 = mkColmenaHost "executive14" "desktop" "ctorgalson" system;

        # ARM appliance (aarch64-linux) - pi0 doesn't use desktop role
        pi0 = { name, nodes, ... }: {
          deployment = {
            targetHost = "pi0";
            targetUser = "bh";
            buildOnTarget = false; # Build on deployment machine (x86_64)
          };
          _module.args = {
            system = "x86_64-linux"; # Build system
          };
          imports = [
            sops-nix.nixosModules.sops
            ./hosts/pi0
          ];
          nixpkgs.hostPlatform = "aarch64-linux";
        };
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
