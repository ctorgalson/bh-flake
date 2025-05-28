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

      "ssh_keys/id_ed25519/private" = {
        path = "${homedir}/.ssh/id_ed25519";
        owner = username;
        group = "users";
        mode = "600";
      };

      "ssh_keys/id_ed25519/public" = {
        path = "${homedir}/.ssh/id_ed25519.pub";
        owner = username;
        group = "users";
        mode = "644";
      };

      "ssh_keys/id_rsa/private" = {
        path = "${homedir}/.ssh/id_rsa";
        owner = username;
        group = "users";
        mode = "600";
      };

      "ssh_keys/id_rsa/public" = {
        path = "${homedir}/.ssh/id_rsa.pub";
        owner = username;
        group = "users";
        mode = "644";
      };
    };
  };
}
