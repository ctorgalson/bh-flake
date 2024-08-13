{ config, pkgs, home, programs, ... }:

{
  config = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}

