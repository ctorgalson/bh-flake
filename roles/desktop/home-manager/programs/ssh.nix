{ host, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      # Note: enableDefaultConfig option not available in Home Manager 25.05
      # Previously used to disable auto-generated defaults like:
      #   ForwardAgent no, ServerAliveInterval 0, etc.
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
        "pi0" = {
          hostname = "pi0";
          user = "bh";
          extraOptions = {
            StrictHostKeyChecking = "no";
          };
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
