{ allowedUnfreePackages, inputs, lib, pkgs, stylix, ... }:

{
  imports = [
    ./boot
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
    ./xdg
    # From flakes etc.
    ./stylix
  ];
}
