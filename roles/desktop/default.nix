{ allowedUnfreePackages, host, inputs, lib, pkgs, system, ... }:

{
  imports = [
    ./nixos
  ];

  home-manager.users."ctorgalson" = ./home-manager;
}
