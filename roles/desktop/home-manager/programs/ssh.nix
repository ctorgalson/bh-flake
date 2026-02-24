{ host, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      # Note: enableDefaultConfig option not available in Home Manager 25.05
      # Previously used to disable auto-generated defaults like:
      #   ForwardAgent no, ServerAliveInterval 0, etc.
      extraConfig = ''
        LogLevel ERROR

        # Host *.upsun.com
        #   Include /home/${host.username}/.upsun-cli/ssh/*.config
      '';
      matchBlocks = {
        "*" = {
          IdentityAgent = "/home/${host.username}/.bitwarden-ssh-agent.sock";
        };
        "*.anner.ie" = {
          user = "at";
        };
        "*.upsun.com" = {
          hostname = "*.upsun.com";
          include = "/home/${host.username}/.upsun-cli/ssh/*.config";
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
