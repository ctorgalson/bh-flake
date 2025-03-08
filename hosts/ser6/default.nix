# ser6
{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nixos/stylix
  ];
}

