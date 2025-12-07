{ config, inputs, lib, pkgs, ... }:

{
  # imports = [
  #   ./hardware-configuration.nix
  #   ../../modules/nixos/desktop-configuration.nix
  #   ../../modules/nixos/main-user.nix
  # ];

  boot.loader.systemd-boot.enable = true;
  # 2025-11-29: systemd 258.2 still has efivars assertion bug (efivars.c:104).
  # Bug persists despite PR #35497. Workaround: disable EFI variable writes.
  boot.loader.efi.canTouchEfiVariables = false;
  boot.initrd.luks.devices."luks-531e1b9c-cd19-4c63-830d-f6fb1cd0172f".device = "/dev/disk/by-uuid/531e1b9c-cd19-4c63-830d-f6fb1cd0172f";

  networking.hostName = "framework13";

  # Configure SOPS secret for Tailscale auth key
  sops.secrets.tailscale_auth_key = {
    sopsFile = ../../sops/workstation/framework13.yaml;
  };

  # Configure Tailscale to use auth key for automatic connection
  services.tailscale.authKeyFile = config.sops.secrets.tailscale_auth_key.path;

  system.stateVersion = "24.11";
}
