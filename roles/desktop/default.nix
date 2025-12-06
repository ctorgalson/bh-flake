{ config, host, inputs, lib, pkgs, unstable-pkgs, system, ... }:

{
  imports = [
    ../../modules/users.nix
    ./nixos
  ];

  # Configure users for desktop role
  bhFlake.users = {
    enableAdmin = true;
    # No password file - using Tailscale SSH for remote access
    enableDeployment = true;
  };

  home-manager.users."${host.username}" = ./home-manager;
}
