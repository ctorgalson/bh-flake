{ config, pkgs, programs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-git-alias";
          file = "zsh-git-alias.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "vanesterik";
            repo = "zsh-git-alias";
            rev = "main";
            sha256 = "sha256-hXk8+Vg6J1X+y0O8+i4cJydKJM//Bob8hrJ7jDW6kBQ=";
          };
        }
      ];
      shellAliases = {
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
