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
    applications = lib.mkForce 13;
    desktop = lib.mkForce 13;
    popups = lib.mkForce 12;
    terminal = lib.mkForce 15;
  };
}
