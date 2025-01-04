{ config, pkgs, home, ... }:

{
  config = {
    programs.tmux = {
      enable = true;
      mouse = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
          '';
        } 
      ];
    }; 
  };
}
