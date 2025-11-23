# Hardware configuration for Raspberry Pi Zero 2 W
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  # Boot configuration for Raspberry Pi
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Kernel configuration
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  # Enable GPU firmware
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  # File systems - SD card layout
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  # Networking hardware
  networking.wireless.enable = lib.mkDefault true;
  networking.wireless.userControlled.enable = true;

  # Hardware settings
  hardware.enableRedistributableFirmware = true;

  # Power management
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # System architecture
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
