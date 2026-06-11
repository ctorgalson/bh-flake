{ inputs, lib, pkgs, stylix, ... }:

{
  imports = [
    ../../../modules/nixos/ssh.nix
    ../../../modules/nixos/iphone-webcam.nix
    ./boot
    ./ddev.nix
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
