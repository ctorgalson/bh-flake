{ config, lib, pkgs, home, ... }:

let
  ansible = pkgs.ansible;
in
{
  config = {
    home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      flake_path="/home/ctorgalson/bh-flake"
      file_path="modules/home-manager/file/playbooks/default_directories.yml"
      ${ansible}/bin/ansible-playbook "''${flake_path}/''${file_path}"
    '';

    home.file = {
      # Byobu
      ".config/byobu/.tmux.conf".source = ../../../dotfiles/byobu/.tmux.conf;
      # Background image
      ".background-image".source = ../../../images/.background-image;
      ".background-image".target = ".background-image";
    };
  };
}
