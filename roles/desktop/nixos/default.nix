{ allowedUnfreePackages, inputs, lib, pkgs, ... }:

{
  imports = [
    ./environment
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./system
    ./time
    ./users
    ./virtualisation
  ];  
}
