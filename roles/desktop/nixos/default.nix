{ inputs, lib, pkgs, stylix, ... }:

{
  imports = [
    ../../modules/ssh.nix
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
    ./virtualisation
    ./xdg
    # From flakes etc.
    ./stylix
  ];
}
