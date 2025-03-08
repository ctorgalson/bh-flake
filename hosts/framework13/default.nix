# framework13
{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nixos/environment
    ./nixos/services
    ./nixos/stylix
    ./home-manager
  ];
}
