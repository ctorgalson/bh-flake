{ config, pkgs, programs, ... }:

{
  config = {
    programs.git = {
      enable = true;
      userName = "Christopher Torgalson";
      userEmail = "manager@bedlamhotel.com";
    };
  };
}
