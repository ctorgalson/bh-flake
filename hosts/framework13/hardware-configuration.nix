{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [
    # https://github.com/FrameworkComputer/SoftwareFirmwareIssueTracker/issues/25
    "amdgpu.dcdebugmask=0x400"
    # https://bbs.archlinux.org/viewtopic.php?id=301734
    # amdgpu.dcdebugmask=0x10
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4ba3fe0e-3c37-4536-b833-6347a458384b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-7b065af5-f102-448b-be49-8764a79720df".device = "/dev/disk/by-uuid/7b065af5-f102-448b-be49-8764a79720df";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BE54-6AC4";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/527f5ab7-8f77-4871-823a-40e20fca7219"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
