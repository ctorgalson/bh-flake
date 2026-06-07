{ config, pkgs, ... }:

{
  # Import shared desktop power management config
  imports = [
    ../../profiles/desktop/nixos/hardware/desktop-power-management.nix
  ];

  # Host-specific overrides can go here if needed
}
