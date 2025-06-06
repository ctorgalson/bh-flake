{ ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *.platform.sh
          Include /home/ctorgalson/.platformsh/ssh/*.config
        Host *
      '';
      matchBlocks = {
        "nx" = {
          hostname = "ct.anner.ie";
          user = "ctorgalson";
          forwardAgent = true;
        };
        "r2" = {
          hostname = "135.181.200.94";
          user = "ctorgalson";
          forwardAgent = true;
        };
        "rcksl" = {
          hostname = "162.55.164.32";
          user = "ctorgalson";
          forwardAgent = true;
        };
      };
    };
  };
}
