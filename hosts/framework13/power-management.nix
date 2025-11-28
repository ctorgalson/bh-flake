{ config, pkgs, ... }:

{
  # Import shared laptop power management config
  imports = [
    ../../roles/desktop/nixos/hardware/laptop-power-management.nix
  ];

  # Host-specific overrides can go here if needed
}
