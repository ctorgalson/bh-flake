# ser6
{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  stylix.fonts.sizes = {
    applications = lib.mkForce 14;
    desktop = lib.mkForce 14;
    popups = 12;
    terminal = lib.mkForce 15;
  };
}

