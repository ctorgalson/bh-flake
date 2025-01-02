{ inputs, config, pkgs, programs, ... }:

{
  config = {
    imports = [
      inputs.nvchad4nix.homeManagerModule
    ];
    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [ ];
      backup = true;
    };
  };
}
