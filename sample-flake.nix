{
  description = "Modular flake for multiple system management.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { flake-utils, home-manager, nixpkgs, self }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        hostname =
          let
            h = builtins.getEnv "HOSTNAME" or builtins.getEnv "HOST";
          in
            if h == "" then
              throw "Error: neither $HOSTNAME nor $HOST is set."
            else
              h;
        servers = [ ];
        role = if builtins.elem hostname servers then "server" else "desktop";
        commonConfig = import ./roles/common;
        roleConfig = import ./roles/${role};
        hostConfig = import ./hosts/${hostname};
        finalConfig = {
          imports = [
            home-manager.nixosModules.home-manager
            commonConfig
            roleConfig
            hostConfig
          ];
        };
        pkgs = import nixpkgs { inherit system; };
      in
      {
        nixosConfigurations = {
          ${hostname} = pkgs.nixosSystem {
            specialArgs = { inherit inputs };
            inherit system;
            configuration = finalConfig;
          };
        };
      }
    );
}
