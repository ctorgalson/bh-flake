{ config, pkgs, home, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      git
    ];

    programs.git = {
      enable = true;
      userName = "Christopher Torgalson";
      userEmail = "manager@bedlamhotel.com";
    };
  };
}
