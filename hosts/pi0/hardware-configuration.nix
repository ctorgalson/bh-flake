# Hardware configuration for Raspberry Pi Zero 2 W
# Most hardware configuration is handled by nixos-raspberrypi flake
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Load USB ethernet driver for Waveshare ETH/USB HAT (RTL8152B)
  boot.kernelModules = [ "r8152" ];
}
