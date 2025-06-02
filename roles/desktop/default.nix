{ allowedUnfreePackages, config, host, inputs, lib, pkgs, stable-pkgs, system, ... }:

{
  imports = [
    ./nixos
  ];

  home-manager.users."ctorgalson" = ./home-manager;

  sops =
  let
    username = "ctorgalson";
    homedir = "/home/ctorgalson";
  in
  {
    defaultSopsFile = ../../sops/secrets.yaml;
    age.keyFile = "${homedir}/.config/sops/age/keys.txt";

    secrets = {
      # "example_number" = { };
    };
  };
}
