{ allowed-unfree-packages, config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/desktop-configuration.nix
      ../../modules/nixos/main-user.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0c5bd87e-16c8-4d5a-9ed3-4212402e8789".device = "/dev/disk/by-uuid/0c5bd87e-16c8-4d5a-9ed3-4212402e8789";
  networking.hostName = "executive14"; # Define your hostname.

  system.stateVersion = "24.05";
}
