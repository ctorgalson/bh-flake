{ inputs, config, pkgs, programs, ... }:

{
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  config = {
    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [ ];
      backup = true;
    };
  };
}
