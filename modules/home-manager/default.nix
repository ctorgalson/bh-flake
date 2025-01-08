{ config, ... }:

{
  imports = [
    ./dconf
    ./file
    ./pkgs
    ./programs
  ];

  config = {
    home = {
      username = "ctorgalson";
      homeDirectory = "/home/ctorgalson";

      sessionVariables = {
        VISUAL = "nvim";
        GIT_EDITOR="vim -c 'set buftype='";
      };

      stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
  };
}
