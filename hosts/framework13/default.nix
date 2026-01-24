# framework13
{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./host-overrides.nix
    ./power-management.nix
    ../../modules/captive-portal.nix
  ];
}
