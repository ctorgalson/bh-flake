{ allowedUnfreePackages, config, host, inputs, lib, pkgs, system, ... }:

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
      id_ed25519 = {
        path = "${homedir}/.ssh/id_ed25519";
        owner = username;
        group = "users";
        mode = "600";
      };

      id_ed25519_pub = {
        path = "${homedir}/.ssh/id_ed25519.pub";
        owner = username;
        group = "users";
        mode = "644";
      };

      id_rsa = {
        path = "${homedir}/.ssh/id_rsa";
        owner = username;
        group = "users";
        mode = "600";
      };

      id_rsa_pub = {
        path = "${homedir}/.ssh/id_rsa.pub";
        owner = username;
        group = "users";
        mode = "644";
      };
    };
  };
}
