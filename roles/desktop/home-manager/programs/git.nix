{ config, pkgs, programs, ... }:

{
  config = {
    programs = {
      git = {
        enable = true;
        ignores = [
          ".phpactor.json"
        ];
        settings = {
          user = {
            name = "Christopher Torgalson";
            email = "manager@bedlamhotel.com";
          };
        };
      };
    };
  };
}
