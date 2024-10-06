{ config, lib, pkgs, home, ... }:

{
  config = {
    home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      dirs=( 'Dev/BH' 'Dev/AT' 'Storage/Documents' 'Storage/Nextcloud' )
      links=( 'Documents' 'Nextcloud' )
      for dir in "''${dirs[@]}"; do
        dirpath="/home/ctorgalson/$dir"
        if [ ! -d "$dirpath" ]; then
          echo "Create $dirpath"
          mkdir -p "$dirpath"
        fi
      done
      for link in "''${links[@]}"; do
        filepath="/home/ctorgalson/Storage/$link"
        linkpath="/home/ctorgalson/$link"
        if [ -d "$linkpath" ]; then
          # Fail on purpose if this exists and is not empty.
          rmdir "$linkpath"
        fi
        if [ ! -l "$linkpath" ]; then
          echo "Create symlink to $filepath"
          ln -s "$filepath" "$linkpath"
        fi
      done
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
