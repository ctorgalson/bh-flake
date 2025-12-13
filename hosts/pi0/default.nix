# pi0 - Raspberry Pi Zero 2 W network appliance
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./sd-image.nix
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
