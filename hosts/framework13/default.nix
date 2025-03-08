# framework13
{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nixos/environment
    ./nixos/services
    ./home-manager
  ];

  stylix.fonts.sizes = {
    applications = lib.mkForce 12;
    desktop = lib.mkForce 12;
    popups = lib.mkForce 10;
    terminal = lib.mkForce 13;
  };
}
