{ allowedUnfreePackages, inputs, lib, pkgs, stylix, ... }:

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
    # From flakes etc.
    ./stylix
  ];  
}
