{ inputs, lib, pkgs, stylix, ... }:

{
  imports = [
    ../../../modules/ssh.nix
    ./boot
    ./environment
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./sops
    ./system
    ./time
    ./virtualisation
    ./xdg
    # From flakes etc.
    ./stylix
  ];
}
