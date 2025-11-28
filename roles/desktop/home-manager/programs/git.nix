{ config, pkgs, programs, ... }:

{
  config = {
    programs = {
      git = {
        enable = true;
        ignores = [
          ".phpactor.json"
        ];
        userName = "Christopher Torgalson";
        userEmail = "manager@bedlamhotel.com";
      };
    };
  };
}
