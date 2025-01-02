{ config, pkgs, programs, ... }:

{
  config = {
    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [
      ];
      backup = true;
    };
  };
}
