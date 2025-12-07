{ config, host, pkgs, ... }:

{
  # SOPS configuration for desktop role
  sops = {
    defaultSopsFile = ../../../../sops/secrets.yaml;

    # Deploy shared editing key for SOPS CLI
    secrets.age_key = {
      sopsFile = ../../../../sops/workstation/shared.yaml;
      owner = host.username;
      mode = "0600";
      path = "/home/${host.username}/.config/sops/age/keys.txt";
    };

    # Configure SOPS to use SSH host keys (auto-detected)
    # The deployed age_key is for CLI editing only
  };

  # Install ssh-to-age for converting SSH keys to age format
  environment.systemPackages = with pkgs; [
    ssh-to-age
  ];
}
