{ host, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      # Disable auto-generated defaults. Previously home-manager added:
      #   ForwardAgent no
      #   ServerAliveInterval 0
      #   ServerAliveCountMax 3
      #   Compression no
      #   AddKeysToAgent no
      #   HashKnownHosts no
      #   UserKnownHostsFile ~/.ssh/known_hosts
      #   ControlMaster no
      #   ControlPath ~/.ssh/master-%r@%n:%p
      #   ControlPersist no
      enableDefaultConfig = false;
      extraConfig = ''
        Host *.upsun.com
          Include /home/${host.username}/.upsun-cli/ssh/*.config
      '';
      matchBlocks = {
        "*" = {};
        "*.anner.ie" = {
          user = "at";
        };
        "nx" = {
          hostname = "ct.anner.ie";
          user = host.username;
          forwardAgent = true;
        };
        "r2" = {
          hostname = "135.181.200.94";
          user = host.username;
          forwardAgent = true;
        };
        "rcksl" = {
          hostname = "162.55.164.32";
          user = host.username;
          forwardAgent = true;
        };
      };
    };
  };
}
