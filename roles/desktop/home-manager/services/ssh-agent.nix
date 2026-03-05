{ host, ... }:

{
  config = {
    services.ssh-agent = {
      enable = true;
      # Automatically add these keys when agent starts
      keys = [
        "/home/${host.username}/.ssh/id_ed25519_sk_annertech"
      ];
    };
  };
}
