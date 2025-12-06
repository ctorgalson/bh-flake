{ host, pkgs, ... }:

{
  # SOPS configuration for desktop role
  sops = {
    defaultSopsFile = ../../../../sops/secrets.yaml;
    age = {
      keyFile = "/home/${host.username}/.config/sops/age/keys.txt";
      sshKeyPaths = [
        "/home/${host.username}/.ssh/id_ed25519_sops"
      ];
    };
  };

  # Install ssh-to-age for converting SSH keys to age format
  environment.systemPackages = with pkgs; [
    ssh-to-age
  ];
}
