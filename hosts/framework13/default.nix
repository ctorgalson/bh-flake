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
    applications = lib.mkForce 11;
    desktop = lib.mkForce 11;
    popups = lib.mkForce 9;
    terminal = lib.mkForce 12;
  };
}
