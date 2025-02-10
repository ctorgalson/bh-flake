{ allowed-unfree-packages, config, inputs, lib, pkgs, ... }:

{
  # imports = [
  #   ./hardware-configuration.nix
  #   ../../modules/nixos/desktop-configuration.nix
  #   ../../modules/nixos/main-user.nix
  # ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-531e1b9c-cd19-4c63-830d-f6fb1cd0172f".device = "/dev/disk/by-uuid/531e1b9c-cd19-4c63-830d-f6fb1cd0172f";

  networking.hostName = "framework13";

  system.stateVersion = "24.11";
}
