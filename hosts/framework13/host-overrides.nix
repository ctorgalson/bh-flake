# framework13 host-specific overrides
{ config, host, lib, pkgs, ... }:

{
  # Fingerprint reader support
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd.enable = true;

  # Font size overrides for higher DPI display
  stylix.fonts.sizes = {
    applications = lib.mkForce 11;
    desktop = lib.mkForce 11;
    popups = lib.mkForce 9;
    terminal = lib.mkForce 12;
  };

  home-manager.users."${host.username}".config = {
    programs.kitty.font.size = lib.mkForce 13;
  };
}
