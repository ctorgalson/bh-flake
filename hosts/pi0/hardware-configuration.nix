# Hardware configuration for Raspberry Pi Zero 2 W
# Based on plmercereau/nixos-pi-zero-2
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Some packages fail to build kernel modules, bypass that
  # https://discourse.nixos.org/t/does-pkgs-linuxpackages-rpi3-build-all-required-kernel-modules/42509
  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot = {
    # Use the Pi Zero 2 W specific kernel package
    kernelPackages = pkgs.linuxPackages_rpi02w;

    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];

    # Load USB ethernet driver for Waveshare ETH/USB HAT (RTL8152B)
    kernelModules = [ "r8152" ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    # Avoids warning: mdadm: Neither MAILADDR nor PROGRAM has been set
    swraid.enable = lib.mkForce false;
  };

  hardware = {
    enableRedistributableFirmware = lib.mkForce false;
    firmware = [ pkgs.raspberrypiWirelessFirmware ]; # Keep this to make sure wifi works

    deviceTree = {
      enable = true;
      kernelPackage = pkgs.linuxKernel.packages.linux_rpi3.kernel;
      filter = "*2837*"; # BCM2837 is the SoC for Pi Zero 2 W
    };
  };

  # File systems for deployed system (not SD image build)
  fileSystems."/" = lib.mkIf (!(config.system.build ? sdImage)) {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = lib.mkIf (!(config.system.build ? sdImage)) {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
  };
}
