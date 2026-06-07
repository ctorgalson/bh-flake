{ inputs, unstable-pkgs }:

let
  inherit (inputs) nixpkgs home-manager sops-nix stylix;
  system = "x86_64-linux";
in
{
  mkColmenaHost = hostname: profile: username: hostSystem: {
    deployment = {
      targetHost = hostname;
      targetUser = "bh";
      allowLocalDeployment = true;
    };

    _module.args = {
      host = { inherit hostname profile username; };
    };

    imports = [
      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
      home-manager.nixosModules.default
      {
        home-manager.extraSpecialArgs = {
          inherit inputs unstable-pkgs;
          host = { inherit hostname profile username; };
        };
        home-manager.backupFileExtension = "bak";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
      ../profiles/${profile}
      ../hosts/${hostname}
    ];

    nixpkgs.hostPlatform = hostSystem;
  };

  mkHost = hostname: profile: username:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs unstable-pkgs;
        host = { inherit hostname profile username; };
      };
      modules = [
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        home-manager.nixosModules.default
        {
          nixpkgs.hostPlatform = system;
          home-manager.extraSpecialArgs = {
            inherit inputs unstable-pkgs;
            host = { inherit hostname profile username; };
          };
          home-manager.sharedModules = [
            # sops-nix.homeManagerModules.sops
            # stylix.homeManagerModules.stylix
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        # profile configuration.
        ../profiles/${profile}
        # host configuration (including profile overrides).
        ../hosts/${hostname}
      ];
    };
}
