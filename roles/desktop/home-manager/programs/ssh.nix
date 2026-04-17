{ host, config, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          extraOptions.LogLevel = "ERROR";
        };
        "*.upsun.com" = {
          extraOptions.Include = "/home/${host.username}/.upsun-cli/ssh/*.config";
        };
        "*.anner.ie" = {
          user = "at";
        };
        "nx" = {
          hostname = "ct.anner.ie";
          user = host.username;
          forwardAgent = true;
          identityFile = "/home/${host.username}/.ssh/id_ed25519_sk_annertech";
          identitiesOnly = true;
          identityAgent = "/run/user/1000/ssh-agent";
        };
      };
    };
  };
}
