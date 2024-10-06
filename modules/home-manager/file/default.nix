{ config, lib, pkgs, home, ... }:

{
  config = {
    home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      flake_path="/home/ctorgalson/bh-flake"
      file_path="modules/home-manager/file/default_directories.sh"
      "''${flake_path}/''${file_path}"
    '';

    home.file = {
      # Byobu
      ".config/byobu/.tmux.conf".source = ../../../dotfiles/byobu/.tmux.conf;
    };
  };
}
