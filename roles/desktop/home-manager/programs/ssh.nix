{ host, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *.upsun.com
          Include /home/${host.username}/.upsun-cli/ssh/*.config
        Host *
      '';
      matchBlocks = {
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
