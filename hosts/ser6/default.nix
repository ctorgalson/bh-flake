{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  stylix.fonts.sizes = {
    applications = lib.mkForce 13;
    terminal = lib.mkForce 13;
  };
}

