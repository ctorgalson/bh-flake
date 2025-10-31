{ allowedUnfreePackages, config, host, inputs, lib, pkgs, stable-pkgs, system, ... }:

{
  imports = [
    ./nixos
  ];

  home-manager.users."${host.username}" = ./home-manager;

  sops =
  let
    username = host.username;
    homedir = "/home/${host.username}";
  in
  {
    defaultSopsFile = ../../sops/secrets.yaml;
    age.keyFile = "${homedir}/.config/sops/age/keys.txt";

    secrets = {
      "wifi_config" = {};
      # "example_number" = { };
    };
  };
}
