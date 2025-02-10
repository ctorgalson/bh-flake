{ allowedUnfreePackages, inputs, lib, pkgs, ... }:

{
  imports = [
    ./environment
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./services
    ./system
    ./time
    ./virtualisation
  ];  
}
