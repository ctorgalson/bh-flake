{ config, lib, pkgs, home, ... }:

{
  config = {
    # Create expected directories.
    home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      dirs=( 'Dev/BH' 'Dev/AT' 'Nextcloud' )
      for dir in "''${!fruits[@]}"; do
        path="$HOME/$dir"
        if [ ! -d "$path" ]; then
          mkdir -p "$path"
        fi
      done
    '';

    home.file = {
      # Byobu
      ".config/byobu/.tmux.conf".source = ../../../dotfiles/byobu/.tmux.conf;
    };
  };
}
