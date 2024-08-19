{ config, lib, pkgs, home, ... }:

{
  config = {
    # Create expected directories.
    home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      dirs=( 'Dev/BH' 'Dev/AT' 'Nextcloud' )
      for dir in "''${dirs[@]}"; do
        dirpath="/home/ctorgalson/$dir"
        if [ ! -d "$dirpath" ]; then
          echo "Create $dirpath"
          mkdir -p "$dirpath"
        fi
      done
    '';

    home.file = {
      # Byobu
      ".config/byobu/.tmux.conf".source = ../../../dotfiles/byobu/.tmux.conf;
    };
  };
}
