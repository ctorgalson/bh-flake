{ config, pkgs, home, ... }:

{
  config = {
    home.file = {
      # Byobu
      ".config/byobu/.tmux.conf".source = ../../../dotfiles/byobu/.tmux.conf;
    };
  };
}
