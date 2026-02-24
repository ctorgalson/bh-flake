{ config, host, pkgs, ... }:

{
  # SOPS configuration for desktop role
  sops = {
    defaultSopsFile = ../../../../sops/secrets.yaml;

    # Deploy shared editing key for SOPS CLI
    secrets = {
      age_key = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
        path = "/home/${host.username}/.config/sops/age/keys.txt";
      };

      ansible_galaxy_api_token = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
        path = "/home/${host.username}/.ansible/galaxy_token";
      };

      gitlab_host_at = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
      };

      gitlab_token_at = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
      };

      id_ed_25519_sk_annertech = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
        path = "/home/${host.username}/.ssh/id_ed_25519_sk_annertech";
      };

      id_ed_25519_sk_annertech_pub = {
        sopsFile = ../../../../sops/workstation/shared.yaml;
        owner = host.username;
        mode = "0600";
        path = "/home/${host.username}/.ssh/id_ed_25519_sk_annertech.pub";
      };
    };

    # Configure SOPS to use SSH host keys (auto-detected)
    # The deployed age_key is for CLI editing only
  };

  # Install ssh-to-age for converting SSH keys to age format
  environment.systemPackages = with pkgs; [
    ssh-to-age
  ];
}
