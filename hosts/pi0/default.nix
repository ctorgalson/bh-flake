# pi0 - Raspberry Pi Zero 2 W network appliance
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
